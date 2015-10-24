---
layout: post
title: Hudson 1.344 Released
nodeid: 150
created: 1265652000
tags:
- development
- feedback
- just for fun
- links
---
The latest release of Hudson, 1.344, was released on February 5th, 2010. The release contains primarily bug-fixes but has a few enhancements baked into it as well. As mentioned in "[Incoming! More Translations](http://blog.hudson-ci.org/content/incoming-more-translations)", 1.344 incorporates a number of community-driven translations (see the other post for more information). Additionally, 1.344 removes the "easter egg" background image I wrote about in a post to my personal blog: [Mourning Sun](http://unethicalblogger.com/posts/2010/01/mourning_sun).

Enough of the small talk, here's the breakdown.


#### Bugs fixed
<ul class=image>
  <li class=bug>
    Removed the forced upper casing in parameterized builds.
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-5391">issue 5391</a>)
  <li class=bug>
    Password parameter on the disk should be encrypted.
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-5420">issue 5420</a>)
  <li class=bug>
    Duplicate entries on Upstream/Downstream project with "Build modules in parallel".
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-5293">issue 5293</a>)
  <li class=bug>

    "Projects tied on" should be "Projects tied to".
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-5451">issue 5451</a>)
  <li class=bug>
    Fixed the bug that prevents update center metadata retrieval in Jetty.
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-5210">issue 5210</a>)
</ul>

<br clear="all"/>
#### Enhancements
<ul>
  <li class=rfe>
    Show which plugins have already been upgraded in Plugin Manager.
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-2313">issue 2313</a>)
  <li class=rfe>
    Show Hudson upgrade status on manage page instead of offering same upgrade again.
    (<a href="http://issues.hudson-ci.org/browse/HUDSON-3055">issue 3055</a>)
  <li class=rfe>

    Make badges in build history line up.
    (<a href="http://n4.nabble.com/Align-lock-sign-of-keep-build-forever-td1016427.html">report</a>)
</ul>


<br clear="all"/>
#### Contributors 
This release of Hudson contained 44 commits from 5 different contributors to "core":

* <a id="aptureLink_AkeTULcLLb" href="http://twitter.com/abayer">abayer</a>
* <a id="aptureLink_YaPunVjeFQ" href="http://twitter.com/kohsukekawa">kohsuke</a>
* <a id="aptureLink_XwoYyUAc5v" href="http://blogs.sun.com/mindless">mindless</a>
* <a id="aptureLink_IPwBJtA60V" href="http://twitter.com/ssogabe">sogabe</a>
* <a id="aptureLink_ihPia31Muh" href="http://www.linkedin.com/in/thuybrechts">huybrechts</a> (contributed a couple patches via [his GitHub fork](http://github.com/huybrechts/hudson) of [Kohsuke's hudson git repository](http://github.com/kohsuke/hudson))


<br clear="all"/>
As usual, you can go grab the [latest .war file](http://hudson-ci.org/latest/hudson.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
**Update:** This post was written a day before [issue 5536](http://issues.hudson-ci.org/browse/HUDSON-5536) was discovered. I recommend waiting until 1.345 to update any production Hudson instances.
<!--break-->
