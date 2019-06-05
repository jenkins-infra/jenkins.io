---
:layout: post
:title: Hudson 1.349 Released
:nodeid: 181
:created: 1268049600
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
Last Friday, March 5th, Hudson 1.349 was pushed out into the wild with an even split of bug fixes and enhancements. Included in this release is Alan Harder's (a.k.a `mindless`) old data monitor code, discussed previously in the post "[Call for Testers: The older the better](https://jenkins.io/content/call-testers-older-better)." Included in this release were further updates to the japanese and german localizations of Hudson; if you're interested in helping localize Hudson into more languages you can join the effort via the [Internationalization page on the wiki](https://wiki.jenkins.io/display/JENKINS/Internationalization).


Now for the breakdown of the 1.349 release:


#### Bug fixes
<ul class=image> 
  <li class=bug> 
    Fix deserialization problem with fields containing double underscore.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5768">issue 5768</a>)
  <li class=bug> 
    Fix deserialization problem for Exception objects where the XML has bad/old data.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5769">issue 5769</a>)
  <li class=bug> 
    Fix serialization problem with empty CopyOnWriteMap.Tree.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5776">issue 5776</a>)
  <li class=bug> 
    Fixed a bug that can cause 404 in the form validation check.
</ul> 

<br clear="all"/>
#### Enhancements
<ul>
  <li class=rfe> 
    Remote build result submission shouldn't hang forever even if Hudson goes down.
  <li class=rfe> 
    Added a monitor for old or unreadable data in XML files and a manage screen to assist
    in updating files to the current data format and/or removing unreadable data from plugins
    that are no longer active.  "Manage Hudson" page will show a link if any old/unreadable
    data was detected.
  <li class=rfe> 
    Added a mechanism to bundle <tt>init.groovy</tt> inside the war for OEM.
    (<a href="https://n4.nabble.com/preconfigured-hudson-war-tp1575216p1575216.html">report</a>)
  <li class=rfe> 
    Added an extension point to annotate console output.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-2137">issue 2137</a>)</ul>


<br clear="all"/>
#### Contributors
Hudson 1.349 contains **43** commits from 6 contributors, due to the merging in of Alan Harder's old-data-monitor branch the commit count is a bit off from the amount of code change that actually went out in 1.349.

* <a id="aptureLink_AkeTULcLLb" href="https://twitter.com/abayer">abayer</a>
* <a id="aptureLink_YaPunVjeFQ" href="https://twitter.com/kohsukekawa">kohsuke</a>
* <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a>
* <a id="aptureLink_IPwBJtA60V" href="https://twitter.com/ssogabe">sogabe</a>
* swiest
* <a id="aptureLink_VY2dBrA1mQ" href="https://twitter.com/wyukawa">wyukawa</a>



<br clear="all"/>
As usual, you can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
<!--break-->
