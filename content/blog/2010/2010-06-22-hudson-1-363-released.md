---
:layout: post
:title: Hudson 1.363 Released!
:nodeid: 216
:created: 1277215200
:tags:
- general
- releases
- jenkinsci
:author: rtyler
---
<img src="/sites/default/files/images/Hudson_coatofarms.gif" align="left" hspace="6"/> Last Friday the Hudson team released release **1.363** which is yet another mixed bag of enhancements and bug fixes. Along with the usual bunch of fixes, this release includes a number of localization updates courtesy of a team of Hudson community volunteers participating in the Hudson [Internationalization project](https://wiki.jenkins.io/display/JENKINS/Internationalization).

It is also worth noting that this post is being published on Tuesday, contrary to the schedule that I operated on with Continuous Blog, I will no longer be posting release updates on Monday morning. Traditionally Hudson is released Friday afternoon (PST), meaning any potential regressions are reported early on Monday morning after our European users start to upgrade. Publishing this release announcement on Tuesday gives me more time to test out the release so I can report with greater confidence in the reliability of the update. (*Note*: This may change in the future as we push for easier RC testing capabilities within Hudson)


If you're a regular reader of the Hudson Labs blog, you may also notice that this change log looks eerily similar to the [1.362 announcement](https://jenkins.io/content/hudson-1362-released) from last week. Turns out I had mistakenly taken the upcoming changes from 1.363 and reported them as fixes in 1.362; I've since updated the post regarding 1.362's change log.

#### Bug Fixes
<ul class=image> 
  <li class=bug> 
    Fix queue handling to close locking gap between removing job from queue and starting build,
    to prevent unintended concurrent builds (refactor of change first made in 1.360).
    (<a href="https://hudson.361315.n4.nabble.com/Patch-to-fix-concurrent-build-problem-td2229136.html">report</a>)
  <li class=bug> 
    Allow multiple dependencies between same two projects, as they may trigger under
    different conditions and with different parameters.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5708">issue 5708</a>)
  <li class=bug> 
    Timeline on build trend page should use server timezone instead of always GMT.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6692">issue 6692</a>)
  <li class=bug> 
    Don't mask the cause of the checkout related exception.
  <li class=bug> 
    "who am I?" page should be visible to everyone.
  <li class=bug> 
    Reinstall a JDK when a different version is selected.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5551">issue 5551</a>)
</ul>

#### Enhancements
<ul>
  <li class=rfe> 
    Avoid pointless and harmful redirection when downloading slave.jar. 
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5752">issue 5752</a>)
  <li class=rfe> 
    Cache downloaded JDKs.
  <li class=rfe> 
    Integrated community-contributed translations (Germany, Greek, Spanish, Finnish, Hungarian, Italian, Japanese, French,
    Russian, Slovenian, Dutch, Traditional Chinese, Swedish, Ukrainian, and Portuguese.) 
  <li class=rfe> 
    Upgraded bundled Ant to version 1.8.1.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6562">issue 6562</a>)
</ul>
<!--break-->
----

You can go grab the [latest .war file](https://ftp.osuosl.org/pub/hudson/war/1.363/hudson.war) straight from our [OSL mirror](https://www.osuosl.org) or if you're using a native package, use your package manager to upgrade.
