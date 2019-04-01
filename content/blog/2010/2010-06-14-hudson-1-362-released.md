---
:layout: post
:title: Hudson 1.362 Released
:nodeid: 214
:created: 1276527600
:tags:
- general
- core
- releases
- jenkinsci
:author: rtyler
---
<img src="/sites/default/files/images/hudson.gif" height="150" align="right"/> The 1.362 release of Hudson has a few bug-fixes and a few minor enhancements, all together a good stabilization release. Not too much interesting to discuss so straight on to the changelog!

#### Bugs
<ul class=image>
  <li class=bug> 
    Restored optional container-based authentication for CLI.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6587">issue 6587</a>)
  <li class=bug> 
    Fix javascript error when a plugin uses an empty <tt>dropdownList</tt>, resulting in LOADING overlay being left up.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6542">issue 6542</a>)
</ul>

#### Enhancements
<ul>
  <li class=rfe> 
    Add setting so job views may show only enabled or disabled jobs.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6673">issue 6673</a>)
  <li class=rfe> 
    File parameters can now be downloaded from the build Parameters page.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6719">issue 6719</a>)
  <li class=rfe> 
    Added an ability to point to different update sites.
  <li class=rfe> 
    Added a new extension point to plug in custom utility to kill processes.
  <li class=rfe> 
    Added a proactive error diagnostics to look for a broken reverse proxy setup.
    (<a href="https://wiki.jenkins.io/display/JENKINS/Running+Hudson+behind+Apache#RunningHudsonbehindApache-modproxywithHTTPS">report</a>)
</ul>
<!--break-->
----

You can go grab the [latest .war file](https://ftp.osuosl.org/pub/hudson/war/1.362/hudson.war) straight from our [OSL mirror](https://www.osuosl.org) or if you're using a native package, use your package manager to upgrade.

----

<br clear="all"/>
<small>Image courtesy of [Hudson's Grill](https://hudsonsgrill.com/)</small>
