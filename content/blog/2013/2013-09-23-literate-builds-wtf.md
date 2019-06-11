---
:layout: post
:title: Literate builds, WTF?
:nodeid: 440
:created: 1379964130
:tags:
- development
- plugins
- javaone
:author: kohsuke
---
(This is a guest post by Stephen Connolly)

Every developer, at some stage, will be handed a project to maintain that somebody else was responsible for. If you are lucky, the developer will not have left the organization yet and you get a brief Knowledge Transfer as the developer packs up their desk before heading on to their new job. If you are unlucky, you don't even get given the details of where the source code is hiding.

Now begins the detective work, as you try to figure out how to build and release the project, set up Jenkins jobs to build the project and run the tests…

It doesn't have to be this way, you know!  

What if I told you there was a file sitting at the top level that told you exactly how to build the project and do the important things? You'd be interested, wouldn't you?

When I tell you it's the README file? “But that's all lies. Nobody keeps that up to date. Argh!!!”

But what if Jenkins reads the README file and uses it for the build definition? Now you not only have a CI system ensuring that the build definition is correct, but you have less work to do setting up the job.

What if, because the build definition is now in Source Control, you can have Jenkins create jobs for each branch with ease? The joy of cheap branches that modern source control systems such as GIT and Mercurial give us, no longer comes with the pain of having to create Jenkins jobs for each branch (and more pain having to remember to tidy up when the branch is gone.)

That is the promise delivered by the [Literate plugin](https://wiki.jenkins-ci.org/display/JENKINS/Literate+Plugin).

## How does it work?

First of all, because Jenkins will be looking at all your branches, you need a way to tell Jenkins which branches it makes sense to try and build. For example, if your project lives on GitHub, you are unlikely to want the `gh-pages` branch to be treated like a branch of your actual code, and there are going to be branches that have a README file, but not one that Jenkins understands, so we will want to ignore them too.

You tell Jenkins that a branch is one to build by putting a marker file in the root of the branch. By default the marker file is called `.cloudbees.md`. If the marker file is present and empty, then the literate job type will assume the build instructions are in `README.md`. If the marker file is present and has build instructions, then the literate job type will just use those instructions.

In order to make it easy to provide the instructions, there is rather minimal formatting requirements for a literate description of a project's build commands.

The minimal description is just a section with the word `build` and a verbatim code block in that section. Here is the obligatory minimal “hello world” project description:

    # Build

        echo hello world

or if you don't like indenting you could use the GitHub style triple-back-tick

    # Build

    ```
    echo hello world
    ```

Part of what makes this a [literate style](https://en.wikipedia.org/wiki/Literate_programming) of build description is that you can freely intersperse the description of what and why the commands do with the actual commands, e.g.

    # Build

    We will greet the world with our great literate project description

        echo -n "Hello"

    Now that we have announced our intention to greet some people, we need to qualify exactly who we are greeting

        echo " world"

    That was just perfect. Time for a cup of tea

The first section heading containing the word `build` identifies the section that is assumed to be the build instructions. (The keyword that is searched for is configurable, but not yet exposed in the literate plugin's UI). The following is also a valid `README.md` for printing hello world:

    Our super hello world project
    =============================

    This is a project to say hello to the world

    How to build
    ------------

    You can build this project by running the following command:

        echo hello world

    Credits
    -------

    This project would not have been possible without the existence of Assam loose leaf tea.

Now this is all very well, but what about if you need different instructions for building on Windows versus on Linux, and for that matter how does Jenkins know where we should build this project. Plus Mr Joe Random needs to know what he needs to install on his machine to build it for himself.

The first section containing the word `environment` identifies the section that contains the details of the environments to run the build on.

    Hello world project
    ===================

    This is a simple hello world literate project

    Environment requirements
    ------------------------

    The project is built and tested by Jenkins on the following build environments, so it is known that the build instructions work on the following environments:

    * `windows`
    * `linux`

    How to build
    ------------

    The build instructions are platform dependent:

    * On `windows`:
    
            echo "hello world"

    * On `linux`:

            echo hello\ world

When Jenkins sees bullet points in the `environment` section it assumes each bullet point corresponds to an environment to run the build on. Each environment is specified by at least one code snippet which helps define the requirements of the environment. By default Jenkins will look for tool installers with the same name as the labels. If it cannot find any matching tool installers it assumes that the labels are Jenkins slave node labels. (The strategy is plugable, but not yet exposed in the UI of literate builds)

When you have multiple environments on which to build and test, you have two choices on your build instructions. You can either:

* Have one and only one set of commands that work on all environments; or
* Have bullet points that cover all the specified environments.

So for example, if you are building on the following environments:

* `windows`, `java-1.6`, `ant-1.7`
* `windows`, `java-1.6`, `ant-1.8`
* `windows`, `java-1.7`, `ant-1.8`
* `linux`, `java-1.7`, `ant-1.7`
* `linux`, `java-1.7`, `ant-1.8`

You need to have bullet points in your `build` section that can match each of those options, but as long as there is a match for every option you are ok. So for example:

    ANT version finder
    ==================

    Finding out the version of ANT on various platforms

    Environments
    ------------
    
    Nesting bullet points multiplies out the options

    * `windows`
        * `java-1.6`
            * `ant-1.6`
            * `ant-1.7`
        * `java-1.7`, `ant-1.8`
    * `linux`, `java-1.7` 
        * `ant-1.7`
        * `ant-1.8`

    Build
    -----

    The first match with the highest number of matches wins, so we want windows to get special treatment:

    * `windows`

            call ant.bat -version

    * `java-1.7`

            ant -version

    We could have picked `linux` for the above if we wanted, but this matching will have the same effect and better illustrates how matching works.

That is a mostly complete detail of how the `build` and `environment` sections work. In general everything except verbatim code blocks and bullet points with code snippets get ignored.

There are other sections that the literate project type allows for, these are called “task” sections. We haven't written the code to support them yet, but the idea is that these will work a bit like basic build promotions with the promoted builds plugin. There will be a UI in Jenkins that lets you kick off any of the task sections that you define as being valid for the job type, in pretty much exactly the same was as the promoted builds plugin works.

After that, everything else in the `README.md` is ignored.

## How do I get the test results into Jenkins?

Jenkins is not just about build and test. A lot of the utility in Jenkins comes from the additional reporting plugins that are available for Jenkins. (The build step ones are less relevant with literate style projects because you want to give people consuming the content instructions they can also follow)

So there is additional metadata about your project that you want to give to Jenkins. We put that metadata into a folder called `.jenkins` in the root of your source control.

There are two levels of integration that a Publisher/Notifier can have with the literate project type. The first level is a basic XML description of the plugin configuration. If you have ever looked at the `config.xml` of a Jenkins job, you will be familiar with this format.

If we have a Maven project and we want to collect the Unit test results in Jenkins we might have a `README.md` like this:

    Maven project with tests
    ========================

    Environments
    ------------

    * `java-1.7`, `maven-3.0.5`

    Build
    -----

    ```
    mvn clean verify
    ```

And then we create a `.jenkins/hudson.tasks.junit.JUnitResultArchiver.xml` file with the following:

    <hudson.tasks.junit.JUnitResultArchiver>
      <testResults>**/target/surefire-reports/*.xml, **/target/failsafe-reports/*.xml</testResults>
      <keepLongStdio>true</keepLongStdio>
      <testDataPublishers/>
    </hudson.tasks.junit.JUnitResultArchiver>

The literate plugin adds an Action to all Free-style projects that allows exporting these XML configuration snippets in a `.zip` file for unpacking into your project's source control. Each publisher/notifier has its own file, so it should be easy to mix and match configuration across different projects and enable/disable specific publishers just by adding/removing each publisher's file.

The XML itself can be a bit ugly, so there is a second level integration, where a Publisher/Notifier plugin can implement its own DSL. The literate plugin ships with two such DSLs. One for archiving artifacts and the other for JUnit test results. So the above XML file could be replaced by a `.jenkins/junit.lst` file with the following contents

    **/target/surefire-reports/*.xml
    **/target/failsafe-reports/*.xml

## Not everything makes sense in source control though…

There are always going to be things that you need to configure in Jenkins. So for example there may be some sources of branches that you don't trust. A good example would be pull requests on GitHub. We have a concept of branch properties in the literate project type that will allow defining what exactly a trusted branch source should be allowed do and what an untrusted branch source should be allowed do. It does not make sense for that information to be embedded within the untrusted branch itself.

Similarly coordination between different Jenkins projects is something that does not make sense in source control. The names of those Jenkins projects (and even their existence) is not knowable from source control. It does not make sense to keep that information in source control.

Information about how to map the description of the build environment in the `README.md` file to the build environments available to Jenkins does not make sense in source control because your Jenkins node configuration details may change over time.

In other words, literate projects do not remove the need to configure things in Jenkins. They do however remove a lot of the need, and especially the need to tweak the exact build commands and the location of where build results should be picked up from.

## What's not done yet?

Here is a list of some things I want to see for literate builds:

* A literate build step so that people can use some of the literate magic in their free-style projects while they migrate them to literate-style
* Support for literate task promotion flows (I think Kohsuke has signed up to help deliver this)
* Exposing the configuration points such as the marker file name (a global config option as well as per-project override) and the keywords to search for in the `README.md` (this is mostly UI work)
* Adding in some support for other markup languages (I'd really like to see AsciiDoc formatted README parsing, e.g. `README.asc`)
* Branch properties for untrusted builds (to do things like restrict the build execution to one explicit environment, put an elastic build timeout in place, wrap the shell commands in a chroot jail, etc)
* Branch properties for build secrets (So that the `production` and `staging` branches can get the keys to deploy into their respective environments.
* Collapsing the intermediate level in the UI when there is only one build environment.
* Eliminating the double SCM checkout when the backing SCM supports the `SCMFileSystem` API so that builds work even faster
* Reusing the GIT repository cache when using GIT branch sources.
* Some nicer integration with GitHub (I have most of this done, but I think it would be irresponsible to release this without having the Untrusted branch properties implemented as otherwise Pull Requests could become a vector for abuse)
* Finishing the support for Subversion credentials migration from the legacy credentials storage mechanism to the new Credentials plugin storage mechanism (not strictly literate project related, but Subversion is still a popular SCM and until this gets done we cannot release a version of the Subversion plugin with literate project support)
* Adding nice DSLs for all the Publishers and Notifiers
* Adding SCM support to all the SCM plugins
* Adding branch property support for the Build Wrapper / Build Environment / Job Property plugins where that makes sense.

Having said all that, the core functionality works right now for GIT/Subversion/Mercurial on Jenkins 1.509+, and it is only by playing with this functionality that you can see how this could change the way you use Jenkins.

## How do I try this out myself

Last week Kohsuke set up a new “Experimental” update center in Jenkins OSS. The reason for this new update center is that we have a lot of (potentially disruptive) changes to many plugins and if we started cutting releases, users may get annoyed if they end up upgrading to these plugins until they have all been better tested.

The “Experimental” update center includes plugins that have `alpha` or `beta` in their version number, while the other update centers now exclude those plugin versions.

So if you want to play with these plugins you need to change your Jenkins instance's update center URI to:

    https://updates.jenkins-ci.org/experimental/update-center.json

I would recommend that you use a test Jenkins instance for playing with. 

(WARNING: shameless plug) You could also just fire up a Jenkins in the cloud using CloudBee's DEV@cloud service and follow [these handy instructions](https://developer-blog.cloudbees.com/2013/09/how-to-try-literate-builds-on-devcloud.html) to enable access to the experimental plugins:
 
The 10 best bug reports on literate builds before the Jenkins User Conference next month will receive a prise from CloudBees, Inc. I was able to get a commitment that the prise would be at least a T-shirt. I am hoping to get some more swag added to the prize pool. CloudBees employees or relatives of CloudBees employees are not eligible for the bug report prise!
