---
:layout: post
:title: Hudson 1.352 Released
:nodeid: 168
:created: 1269263700
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
After an exciting week that saw the rushed release of [Hudson 1.351](https://jenkins.io/content/breaking-hudson-1351-released) on Monday following a fairly serious regression, Hudson 1.352 was released mid-Friday with a good mix bug fixes and enhancements. Bundled with this release was another localizations drop including translations for ca, es, fi, fr, hi_IN, it, nl, ru, and sv_SE locales.<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_neon.jpg" align="right" hspace="3" vspace="3"/> In addition to the nice fancy new community contributed translations, which you can help with by installing the [Translation Assistance plugin](https://wiki.jenkins.io/display/JENKINS/Translation+Assistance+Plugin), the 1.352 release includes the subtle enhancement of hyperlinking URLs in the console output.

In general, 1.352 is looking like a very solid release, that said, here's the breakdown for this release:


#### Bugs fixed
<ul class=image> 
  <li class=bug> 
    Fixed a file handle leak when a copy fails.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5899">issue 5899</a>)
  <li class=bug> 
    Replace '&gt;' with '_' in username, as already done for '&lt;'.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5833">issue 5833</a>)
  <li class=bug> 
    Fix <tt>editableComboBox</tt> to select item when mouse click takes more than 100ms.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-2722">issue 2722</a>)
  <li class=bug> 
    Fixed NPE when configuring a view without "Regular expression".
  <li class=bug> 
    Page shouldn't scroll up when the user opens/closes a stack trace in the test failure report.
  <li class=bug> 
    Fixed a bug where Hudson can put a wrong help file link.
    (<a href="https://n4.nabble.com/Resolution-of-help-files-in-jelly-entries-tp1592533p1592533.html">report</a>)
  <li class=bug> 
    Fixed Maven site goal archiving from slaves.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5943">issue 5943</a>)
  <li class=bug> 
    Fixed a regression with NetBeans Hudson plugin progressive console output.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5941">issue 5941</a>)
  <li class=bug> 
    Fixed a situation where a failure in plugin start up can prevent massive number of job loss. </ul>


<br clear="all"/>
#### Enhancements
<ul>
  <li class=rfe> 
    Supported JBoss EAP 5.0.0 GA.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5922">issue 5922</a>)
  <li class=rfe> 
    CLI commands on protected Hudson now asks a password interactively, if run on Java6.
  <li class=rfe> 
    Added CLI 'login' and 'logout' commands so that you don't have to specify a credential
    for individual CLI invocation. 
  <li class=rfe> 
    URLs in the console output are now hyperlinks. 
  <li class=rfe> 
    Improved the URL annotation logic.
  <li class=rfe> 
    Add drag&amp;drop support for <tt>f:repeatable</tt> lists and use this for
    the JDK/Ant/Maven installations in global config so these can be reordered.
  <li class=rfe> 
    Integrated a new round of community-contributed localizations (ca, es, fi, fr, hi_IN, it, nl, ru, and sv_SE locales.)
</ul>
<!--break-->
<br clear="all"/>
#### Contributors
This release contains 63 commits, from six different contributors including our very own [Subversion-loving](https://jenkins.io/content/keeping-your-configuration-and-data-subversion) <a id="aptureLink_Ee9tWyJQUm" href="https://twitter.com/MikeRooney">Mike Rooney</a> (mcrooney).

* <a id="aptureLink_5nO4bAJUea" href="https://twitter.com/abayer">abayer</a>
* <a id="aptureLink_k1FSSV57Pl" href="https://blogs.sun.com/jglick/">jglick</a>
* <a id="aptureLink_7UNdgyqEaS" href="https://twitter.com/kohsukekawa">kohsuke</a>
* <a id="aptureLink_Ee9tWyJQUm" href="https://twitter.com/MikeRooney">mcrooney</a>
* <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a>
* <a id="aptureLink_hkiotPcJud" href="https://twitter.com/ssogabe">sogabe</a>



----

You can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
