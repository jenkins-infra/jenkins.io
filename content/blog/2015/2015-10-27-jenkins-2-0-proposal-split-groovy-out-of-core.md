---
:layout: post
:title: 'Jenkins 2.0 Proposal: Split Groovy out of "core"'
:nodeid: 637
:created: 1445969896
:tags:
- general
- core
- feedback
:author: rtyler
---
As I mentioned in [yesterday's post](/content/jenkins-20-proposal-introduce-policy-api-deprecation), there's been a lot of discussion recently about what "[Jenkins
2.0](https://wiki.jenkins.io/display/JENKINS/Jenkins+2.0)" means. In a recent "Office Hours" session, [Kohsuke Kawaguchi](https://github.com/kohsuke) presented his
vision for **Jenkins 2.0** in a [office
hours](https://www.youtube.com/watch?v=2eVyc_n8i1c) session, the slides for
which can be found [in this Google
Presentation](https://docs.google.com/presentation/d/12ikbbQoMvus_l_q23BxXhYXnW9S5zsVNwIKZ9N8udg4).
Roughly paraphrasing Kohsuke's vision, 2.0 is primarily about making things
better for the thousands of users out there.


This week, we'll be reviewing some *key areas* of the "Jenkins 2.0" proposal.
Asking you, the user community, to provide feedback on these proposals, going
from Jenkins internals to user interface.

Thus far we've covered:

* [Introducing a policy for API deprecation](/content/jenkins-20-proposal-introduce-policy-api-deprecation)

Today's post involves a proposal originally from community member [Jesse Glick](https://github.com/jglick) who has proposed in **[JENKINS-29068](https://issues.jenkins-ci.org/browse/JENKINS-29068)** that [Groovy](http://groovy-lang.org) be split out from the "core" Jenkins distribution. The linked issue expands on what the problem is here:

> Currently Jenkins embeds a distribution of Groovy into "core" for a variety of scripting and management tasks. This version of Groovy is locked into core in such a way that users cannot upgrade Groovy independently from Jenkins itself. If the Jenkins-bundled version were upgraded to a different major version, it may break users' custom scripts as well as plugins that use Groovy due to API changes.

The proposal is relatively straight-forward and affects the many different users and use-cases for the embedded Groovy scripting support in Jenkins:


> For ease of maintenance and modularity it would be useful to split Jenkins' use of Groovy into a library plugin; different clients could request 1.x and 2.x simultaneously by using different versions of the library, etc.
>
> Stuff in core using Groovy that would need to either be put in this library (if infrastructure for other features) or put in another plugin depending on it (if first-class features themselves):


I selected this proposal to feature on this blog, despite its rather technical underpinnings, it will affect core developers, plugin developers, power and casual users alike. I encourage everybody to read through the proposal and its potential impact [on the issue tracker](https://issues.jenkins-ci.org/browse/JENKINS-29068).


### Providing Feedback

We're asking you to read the proposal in
[JENKINS-29068](https://issues.jenkins-ci.org/browse/JENKINS-29068) and provide
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

Stay tuned for the rest of the week as we keep with our theme of going "from the inside out" and help us make Jenkins 2.0 great!
