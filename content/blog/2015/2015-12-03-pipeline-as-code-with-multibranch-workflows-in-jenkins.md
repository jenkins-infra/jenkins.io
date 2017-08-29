---
:layout: post
:title: Pipeline-as-code with Multibranch Workflows in Jenkins
:nodeid: 653
:created: 1449160710
:tags:
- general
- guest post
- tutorial
- pipeline
- workflow
:author: rtyler
---
_Note: This is a guest post by [Kishore Bhatia](https://github.com/kishorebhatia). [Kishore](https://twitter.com/BhatiaKishore) works for [CloudBees](https://www.cloudbees.com), building custom frameworks with Open Source software and helping customers solve engineering problems around continuous delivery and DevOps at scale._

---

This year some great new Jenkins features came out of the butler’s goodie bag - amongst them, the most important one being the ability to realize [continuous delivery pipeline as code](https://www.voxxed.com/blog/2015/06/kohsuke-kawaguchi-the-main-challenge-for-jenkins-is-with-itself/)!
The features like Workflow Multibranch, pipeline-as-code (with a marker file that Jenkins looks for in your application’s SCM repository/branch, aptly named Jenkinsfile) are the foundations to making Jenkins super intelligent to automagically create workflows (rather, a CI/CD pipeline) to build your code and orchestrate the work required to drive your application from concept to delivery!

### Overview

The Workflow Multibranch feature (provided by the [workflow plugin](https://github.com/jenkinsci/workflow-plugin)) provides the following key abilities:

* Automatic Workflow (job) creation in Jenkins per new branch in the repo (assuming webhooks are registered from GH to Jenkins).
* Build specific to that child-branch and its unique scm change and build history.
* Automatic job pruning/deletion for branches deleted from the repository, according to the settings.
* Flexibility to individually configure branch properties, by overriding the parent properties, if required.


Jenkins pipeline-as-code (concept) enables you to maintain your CI/CD workflow logic in the project/application source code repo with no additional configuration to be maintained per branch in Jenkins.

The Workflow script to build/test/deploy your code is always synchronized with the rest of the source code you are working on.

**To demonstrate the concept here** - Let’s use a basic Java Web application project with a Maven pom.xml as shown in the structure below (this is using GitHub as the SCM but you can do this on SVN or Mercurial too).

[This project](https://github.com/kishorebhatia/pipeline-as-code-demo) has a marker file for Jenkins in the repo - `Jenkinsfile`.

<center><a href="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic1.png"><img src="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic1.png" width="600" border="0"/></a></center>


**So, what's a Jenkinsfile?** The [Jenkinsfile](https://github.com/kishorebhatia/pipeline-as-code-demo/blob/master/Jenkinsfile) is essentially your Jenkins Workflow, a script, that defines the CI/CD pipeline logic for a project with steps to build/test/deploy etc. captured in various stages.

So for our sample Java web application, a basic Jenkinsfile could be something like -

    node {
       // Mark the code checkout 'stage'....
       stage 'Checkout'

       // Checkout code from repository
       checkout scm

       // Get the maven tool.
       // ** NOTE: This 'M3' maven tool must be configured
       // **       in the global configuration.
       def mvnHome = tool 'M3'

       // Mark the code build 'stage'....
       stage 'Build'
       // Run the maven build
       sh "${mvnHome}/bin/mvn clean install"
    }

Just having this file in the source code repo root would mean that -

* Jenkins will automatically recognize this branch and create appropriate jobs by itself.
* Quick, 1-step code checkout using: “checkout scm” in your workflow
* Every time a new change is pushed to this branch, the branch is built and the commit status gets updated.
* When the branch is destroyed in the repository, or if Jenkinsfile is removed, the corresponding job gets destroyed from Jenkins automatically (_You can retain these jobs and/or archive the builds for audit/compliance requirements using the retention property - Orphan Item strategy_)

*Note:* there are various mechanisms to promote reuse of Workflow scripts, such as the [Workflow Global Library](https://github.com/jenkinsci/workflow-cps-global-lib-plugin).


### Required Jenkins configuration

Make sure you’ve the latest [Workflow](https://github.com/jenkinsci/workflow-plugin) and (v1.11 as of writing this blog) Workflow Multibranch plugins installed on your Jenkins instance


<center><a href="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic2.png"><img src="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic2.png" width="600" border="0"/></a></center>

Also, ensure that other dependencies, like SCM plugins and build tools, are met:

* Either SVN/Git/Mercurial (depending on your SCM)
* GitHub Branch Source Plugin (optimized to use the GitHub API and improve performance)
* Maven build tool

Finally, make sure you've created the required Webhook from your SCM (Github in this case) to Jenkins.
Here's how to do that:

* [Setting up GitHub Webhooks in Jenkins](https://thepracticalsysadmin.com/setting-up-a-github-webhook-in-jenkins/)
* [Step-by-step guide to setting up Jenkins for GitHub projects](https://gist.github.com/misterbrownlee/3708738)

Then create a new *Multibranch Workflow* Job with configuration as shown below - mainly selecting the Branch Sources (Git, in this example) and providing the branch/repo URL with credentials.

*Branch sources* (Git) - `https://github.com/kishorebhatia/pipeline-as-code-demo` (or a repo where you’ve cloned this source code with Jenkinsfile)

Leave all other properties default and *Save*.


<center><a href="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic3.png"><img src="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic3.png" width="600" border="0"/></a></center>

You’ll observe that Jenkins would perform Branch Indexing on that “cd” job folder and start the workflow for the master branch, with an automatically created new job, named master, under the “cd” folder.

The workflow does a dummy step for application deploys to the environments in this sequence *Staging* -> Waits for manual approval -> *PROD*

Now, let’s create a new branch off of this master branch in your cloned git repo:

* `$ git branch newBranch` (create a newBranch)
* `$ git checkout newBranch` (switches to newBranch)
* `$ git push --set-upstream origin newBranch` (pushes newBranch)

You’ll observe that your Jenkins instance automatically picks up this newBranch and starts running the workflow (with the Jenkinsfile in this newBranch) to build/test/deploy the code.


<center><a href="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic4.png"><img src="http://agentdero.cachefly.net/continuousblog/pipeline-as-code-guest-blog/Pic4.png" width="600" border="0"/></a></center>

Next, if you now delete this `newBranch` (`git branch -D newBranch`), Jenkins will automatically remove the orphan Workflow job for `newBranch`. You can retain these jobs even after the branches are deleted using the *Orphaned Item Strategy* property in the main "cd" job’s configuration.

So we observed the following benefits of this pipeline-as-code approach:

* Overall job definition is a script (Jenkinsfile)
 * Calls your build tools and scripts for details
* The build script can be versioned alongside project sources
 * Jenkins handles feature/experimental branches automatically
* Keep less configuration in `$JENKINS_HOME`


### Dockerized Demo environment

You can also use the following docker image to run this demo with a preconfigured Jenkins environment and the sample job: `jenkinsci/workflow-demo` (i.e. `docker pull jenkinsci/workflow-demo`)


This docker container includes Jenkins with Workflow and Workflow Multibranch plugins, a local git repo with the aforementioned Java web application and Jetty to demonstrate a continuous delivery pipeline of this application deployed and tested across multiple environments in the pipeline with an approval gate before promoting to PROD (like QA, Staging and PROD).


There's a "cd" job pre-configured as a multibranch Workflow job.

Launch the docker demo as: `docker run -p 8080:8080 -p 8081:8081 -p 9418:9418 -ti jenkinsci/workflow-demo`

Now, you can access Jenkins on port 8080 and Jetty on port 8081 from localhost or the IP of your boot2docker/docker-machine environment.

The demo container has a local git repo so you can clone: `git://localhost/repo`. When creating new branches, each branch automatically creates a matching subproject in Jenkins and triggers the build for that branch. The workflow:

* Checks out source code from the same repository and commit as `Jenkinsfile`.
* Builds sources via Maven with unit testing.
* Runs two parallel integration tests that involve deploying the app to ephemeral server instances, which get thrown away when tests are done (this is done by using auto-deployment of Jetty)
* Once integration tests are successful, the webapp gets to the staging server at [localhost:8081/staging](http://localhost:8081/staging/) (or your docker-machine/boot2docker instance IP)
* requires a human to Manually inspect the staging instance, and when ready, approves the deployment to the production server at http://localhost:8081/production/


### References

* [Developer blog by jglick introducing multibranch support](http://developer-blog.cloudbees.com/2015/08/workflow-19-and-multibranch-beta.html)
* [workflow plugin tutorial](https://github.com/jenkinsci/workflow-plugin/blob/master/TUTORIAL.md)
* [workflow plugin presentations](https://github.com/jenkinsci/workflow-plugin#presentations)
* [workflow plugin demo readme](https://github.com/jenkinsci/workflow-aggregator-plugin/tree/master/demo)
