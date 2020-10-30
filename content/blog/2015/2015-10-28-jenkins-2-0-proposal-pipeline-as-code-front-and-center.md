---
:layout: post
:title: 'Jenkins 2.0 Proposal: Pipeline as Code front and center'
:nodeid: 638
:created: 1446052523
:tags:
- general
- core
- pipeline
- workflow
- feedback
:author: rtyler
---
We have been featuring a few proposals this week for what "[Jenkins
2.0](https://wiki.jenkins.io/display/JENKINS/Jenkins+2.0)" is going to include, today we're discussing my personal favorite, which I believe will have a tremendously positive impact for years to come (not to be too biased!): moving the "Pipeline as Code" support in Jenkins to the front and center.

Thus far in this blog series we have reviewed proposals covering:

* [Introducing a policy for API deprecation](/content/jenkins-20-proposal-introduce-policy-api-deprecation)
* [Splitting Groovy out of 'core'](/content/jenkins-20-proposal-split-groovy-out-core)

Today's proposal comes from project founder [Kohsuke Kawaguchi](https://github.com/kohsuke) titled "**[Pipeline as code front and center](https://issues.jenkins-ci.org/browse/JENKINS-31152)**" and represents perhaps the most important and dramatic shift we hope to make in Jenkins 2.0.

This functionality has existed through the [workflow plugin](https://wiki.jenkins.io/display/JENKINS/Workflow+Plugin), which we have discussed at various Jenkins events before but if you're not aware of some of the power behind it, check out this presentation from [Jesse Glick](https://github.com/jglick):

<center><iframe width="480" height="360" src="https://www.youtube-nocookie.com/embed/Q2pZdzaaCXg?rel=0" frameborder="0" allowfullscreen></iframe></center>


The proposal in [JENKINS-31152](https://issues.jenkins-ci.org/browse/JENKINS-31152) expands on the problem we aim to address:

> The default interaction model with Jenkins has been very web UI driven, requiring users to manually create jobs, then manually fill in the details through a web browser. This requires large amounts of effort to create and manage jobs to test and build multiple projects and keeps the actual configuration of a job to build/test/deploy a project separate from the actual code being built/tested/deployed. This prevents users from applying their existing CI/CD best practices to the job configurations themselves.

To address this, Kohsuke is proposing that we :

> Introduce a new subsystem in Jenkins that:
> 
> * lets you design a whole pipeline, not just a single linear set of tasks
> * stores the said pipeline configuration as human-editable `Jenkinsfile` in your SCM
> * makes it automatic to set up new pipelines when `Jenkinsfile` is added
> * differentiates multiple branches in the same repository
>
> This is the key new feature that positions Jenkins for continuous delivery use cases and other more complex automations of today.

Kohsuke's proposal is largely about bringing together a lot of already existing pieces together to provide a *very* compelling experience for new and existing users alike. I hope it is clear now why this proposal is so exciting to me.



### Providing Feedback

We're asking you to read the proposal in
[JENKINS-31152](https://issues.jenkins-ci.org/browse/JENKINS-31152), which itself have some additional tickets linked under it, and provide
feedback if you have it.

If you have ever logged in to the [issue
tracker](https://issues.jenkins-ci.org) or the
[wiki](https://wiki.jenkins.io/), you have a "Jenkins user account" which
means you'll be able to log into the issue tracker and vote for, or comment on
the issue linked above.

(*note*: if you have forgotten your password, use [the account
app](https://jenkins-ci.org/account/) to reset it.)


We're going to review feedback, make any necessary adjustments and either
approve or reject the proposal two weeks from today.


Stay tuned for a couple more posts covering proposals to improve the Jenkins interface and user experience!
