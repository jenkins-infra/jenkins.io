---
:layout: post
:title: Hudson 1.350 Released
:nodeid: 169
:created: 1268658900
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
Finishing off the second week in March, the Hudson team rolled Hudson 1.350 off the assembly line last Friday, bringing a **slew** of fixes. Of particular interest to users of Hudson's various native packages for <a id="aptureLink_TA4o7Z9zPa" href="https://www.crunchbase.com/company/red-hat">Red Hat</a>, <a id="aptureLink_Oxp1Nm6ywp" href="https://www.opensuse.org/">openSuSE</a>, <a id="aptureLink_60jXN9zINs" href="https://www.ubuntu.com/">Ubuntu/Debian</a> and <a id="aptureLink_H9FnLHBvke" href="https://en.wikipedia.org/wiki/Solaris%20%28operating%20system%29">Solaris</a>, was a change that suppress the "self-upgrade" functionality in the "Manage Hudson" page. On the enhancements side of the fence, the team added authentication support to the [Hudson CLI](https://wiki.jenkins.io/display/JENKINS/Hudson+CLI) (<a href="https://issues.jenkins-ci.org/browse/JENKINS-3796">issue 3796</a>) allowing Hudson users with locked down installations to take advantage of everything the CLI has to offer. 

<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/garbageman.jpg" align="right"/>Internal to Hudson, some more changes from Alan Harder (a.k.a <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a>, a.k.a The Garbage Man), deprecating or otherwise removing deprecated APIs. Alan's been doing some great work on Hudson's internals, if you're coming out to [this weekend's hackathon](https://jenkins.io/content/meet-and-hack-alongside-kohsuke-and-co), but sure to pat him on the back for his tireless efforts.
<!--break-->
<br clear="all"/>
#### Bug fixes
<ul class=image>
  <li class=bug>
    Fix handling of relative paths in alternate settings.xml path for Maven projects.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-4693">issue 4693</a>)
  <li class=bug>
    Alternate settings, private repository, profiles, etc were not used in embedded Maven for
    deploy publisher.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-4939">issue 4939</a>)
  <li class=bug>
    Make <tt>editableComboBox</tt> work in repeatable content, such as a build step.
  <li class=bug>
    If content is captured using <tt>&lt;j:set var=".."&gt;..content..&lt;/j:set&gt;</tt>,
    fixed this to use proper HTML rendering when appropriate.
  <li class=bug>
    '&lt;' and '&amp;' in the console output was not escaped since 1.349
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5852">issue 5852</a>)
  <li class='major bug'>
    Fixed an <tt>AbstractMethodError</tt> in SCM polling under some circumstances.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5756">issue 5756</a>)
  <li class='major bug'>
    Fixed a <tt>ClassCastException</tt> in the Subversion plugin - now using Subversion plugin 1.13.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5827">issue 5827</a>)
  <li class=bug>
    The Maven Integration plugin link in the Update Center was going to a dead location.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-4811">issue 4811</a>)
  <li class=bug>
    On RPM/DEB/etc installation, don't offer the self upgrade. It should be done by the native package manager.
    (<a href="https://n4.nabble.com/RPM-for-Hudson-1-345-does-not-Upgrade-Automatically-tp1579580p1579580.html">report</a>)
  <li class=bug>
    Fixed a possible lock up of slaves.
</ul>

<br clear="all"/>
#### Enhancements
<ul>
  <li class=rfe>
    Added advanced option to LogRotator to allow for removing artifacts from old builds
    without removing the logs, history, etc.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-834">issue 834</a>)
  <li class=rfe>
    Authentication support in Hudson CLI.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-3796">issue 3796</a>)
  <li class=rfe>
    Added console annotation support to SCM polling logs.
</ul>


<br clear="all"/>
#### Contributors
The 1.350 release of Hudson contains 54 commits from 6 different contributors,

* <a id="aptureLink_AkeTULcLLb" href="https://twitter.com/abayer">abayer</a>
* <a id="aptureLink_k1FSSV57Pl" href="https://blogs.sun.com/jglick/">jglick</a>
* <a id="aptureLink_YaPunVjeFQ" href="https://twitter.com/kohsukekawa">kohsuke</a>
* manuel_carrasco
* [mfriedenhagen](https://bitbucket.org/mfriedenhagen)
* <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a>

----

You can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
