---
:layout: post
:title: 'Jenkins 2.0 Proposal: Improved "Out of the box" user experience'
:nodeid: 641
:created: 1446226604
:tags:
- general
- core
- feedback
:author: rtyler
---
This week we have featured a number of proposals for what we would like to see in "[Jenkins
2.0](https://wiki.jenkins.io/display/JENKINS/Jenkins+2.0)", the vision of which is to make Jenkins users more efficient, productive and happy. We started with some more internally facing changes and have slowly progressed from the "inside-out" to today's topic: improving the out of the box user experience. That is to say, the experience that a brand-new Jenkins user has when getting started with the server.


Just to recap, so far we've reviewed:

* [Introducing a policy for API deprecation](/content/jenkins-20-proposal-introduce-policy-api-deprecation)
* [Splitting Groovy out of 'core'](/content/jenkins-20-proposal-split-groovy-out-core)
* [Pipeline as code front and center](/content/jenkins-20-proposal-pipeline-code-front-and-center)
* [User experience improvements (part one)](/content/jenkins-20-proposal-ux-improvements-part-one)


The subject of today's proposal is captured in **[JENKINS-31157](https://issues.jenkins-ci.org/browse/JENKINS-31157)**, which, like yesterday's [proposal](/content/jenkins-20-proposal-ux-improvements-part-one), contains a few issues linked from it with more details.

At a high level, the problem aiming to be solved is:

> When a new user installs Jenkins, they are greeted with the main, empty, dashboard which suggests that they "create jobs." This makes no mention of plugins or the configuration options that are relevant to helping the user make Jenkins match their needs.

In past and current versions of Jenkins, if you know what you're looking for it's relatively easy to move around the interface. If you've never used Jenkins before, it can be very challenging to find your way around or even know *what it is possible* to do with Jenkins.

The proposed changes aim to address this initial confusion:

> Instead of changing the post-install defaults, which may not properly represent the user's needs, the first-time user experience should help guide the user through configuration and plugin installation quickly so they can use Jenkins for their needs. Effectively it should be as easy as possible for a user to arrive at a good configuration for their usage.


Jenkins contributor [Tom Fennelly](https://github.com/tfennelly), who has led this discussion on the mailing lists in the past, has posted a good prototype screencast of what some of this might entail:


<center><iframe width="480" height="360" src="https://www.youtube-nocookie.com/embed/kzRR8XR8hu4?rel=0" frameborder="0" allowfullscreen></iframe></center>



### Providing Feedback

We're asking you to read the issues linked from [JENKINS-31157](https://issues.jenkins-ci.org/browse/JENKINS-31157) and comment and vote on those issues accordingly.

If you have ever logged in to the [issue
tracker](https://issues.jenkins-ci.org) or the
[wiki](https://wiki.jenkins.io/), you have a "Jenkins user account" which
means you'll be able to log into the issue tracker and vote for, or comment on
the issue linked above.

(*note*: if you have forgotten your password, use [the account
app](https://jenkins-ci.org/account/) to reset it.)


We're going to review feedback, make any necessary adjustments and either
approve or reject the proposal two weeks from today.



This concludes this week's blog series highlighting some of the Jenkins 2.0 proposals we felt were important to discuss with the broader Jenkins user audience. Many of these, and other minor proposals, can be found on the [Jenkins 2.0 wiki page](https://wiki.jenkins.io/display/JENKINS/Jenkins+2.0).
