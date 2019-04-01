---
:layout: post
:title: 'Jenkins 2.0 Proposal: Introduce a policy for API deprecation'
:nodeid: 636
:created: 1445833065
:tags:
- general
- core
- feedback
:author: rtyler
---
Over the past few weeks there has been a vibrant discussion happening on the
[jenkinsci-dev@](https://groups.google.com/group/jenkinsci-dev/topics) mailing
list as to what "[Jenkins
2.0](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+2.0)" means.  While
Jenkins does not currently adhere to [semantic versioning](https://semver.org/),
the change of a major version number does indicate a major milestone for the community.

Project founder, [Kohsuke Kawaguchi](https://github.com/kohsuke) presented his
vision for **Jenkins 2.0** in a [office
hours](https://www.youtube.com/watch?v=2eVyc_n8i1c) session, the slides for
which can be found [in this Google
Presentation](https://docs.google.com/presentation/d/12ikbbQoMvus_l_q23BxXhYXnW9S5zsVNwIKZ9N8udg4).
Roughly paraphrasing Kohsuke's vision, 2.0 is primarily about making things
better for the thousands of users out there.


This week, we'll be reviewing some *key areas* of the "Jenkins 2.0" proposal.
Asking you, the user community, to provide feedback on these proposals, going
from Jenkins internals to user interface.


Today's post involves a proposal to introduce a policy for **API
deprecation** from community members [Oliver
Gondža](https://github.com/olivergondza) and [Daniel
Beck](https://github.com/daniel-beck). Extensibility is the heart of Jenkins, but over the past ten
years we've not had a proper API deprecation policy other than "try not to
break plugins, ever."

Daniel, expanding more on the problem wrote:

> We have no backward compatibility policy besides "compatibility matters".
> With 1000+ plugins and basically the entire core being available to
> plugins, a lot of difficult or impossible to remove cruft has accumulated over
> the last ten years. This limits both what can be changed in core, and makes
> documentation difficult to use for plugin developers.

The two have put together a detailed proposal under
**[JENKINS-31035](https://issues.jenkins-ci.org/browse/JENKINS-31035)** which
suggests we:

> limit the availability in APIs (classes, methods, fields, …) provided by core
> to a number of releases. Depending on the feature, this can range from a few
> months, to a few years (e.g. two years being about 100 releases of Jenkins and
> eight LTS baselines).
>
> [...]

I highly encourage you to read the entire proposal [on the issue
tracker](https://issues.jenkins-ci.org/browse/JENKINS-31035), where we are
trying to collect feedback/history.


### Providing Feedback

We're asking you to read the proposal in
[JENKINS-31035](https://issues.jenkins-ci.org/browse/JENKINS-31035) and provide
feedback if you have it.

If you have ever logged in to the [issue
tracker](https://issues.jenkins-ci.org) or the
[wiki](https://wiki.jenkins-ci.org/), you have a "Jenkins user account" which
means you'll be able to log into the issue tracker and vote for, or comment on
the issue linked above.

(*note*: if you have forgotten your password, use [the account
app](https://jenkins-ci.org/account/) to reset it.)


We're going to review feedback, make any necessary adjustments and either
approve or reject the proposal two weeks from today.

Stay tuned, and help make Jenkins 2.0 great!
