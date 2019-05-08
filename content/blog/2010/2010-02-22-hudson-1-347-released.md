---
:layout: post
:title: Hudson 1.347 Released
:nodeid: 196
:created: 1266849000
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
The release of Hudson 1.347 last friday, February 19th, was a relatively "minor" one insofar that it contained an assortment of smaller fixes instead of fixes to major regressions (they weren't any to be fixed) or major features added. There were however some notable commits in this release cycle that didn't make the changelog just yet, for example <a id="aptureLink_TgMtrwa0Sz" href="https://twitter.com/_godin_">godin</a> committed an <a id="aptureLink_HxZkmWKjTi" href="https://en.wikipedia.org/wiki/Ebuild">ebuild</a> which will allow for a native package of Hudson for <a id="aptureLink_uU6StMFk4O" href="https://en.wikipedia.org/wiki/Gentoo%20Linux">Gentoo Linux</a>, joining the ranks of the existing packages for Debian/Ubuntu, FreeBSD, OpenSolaris, openSUSE and RedHat/Fedora Linux. The bundled Subversion plugin was updated and thanks to <a id="aptureLink_IPwBJtA60V" href="https://twitter.com/ssogabe">sogabe</a> and <a id="aptureLink_9NWuFKYOM9" href="https://twitter.com/wyukawa">wyukawa</a> the Japanese translations for Hudson got some updates as well. 

For Hudson developers, both plugin and core, this release contains some notable changes from <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a> (a.k.a Alan Harder), a number of calls which have been deprecated for over **two years** have finally been pruned from the code base:

* `Hudson.addListener(JobListener)`, `Hudson.removeListener(JobListener)`
* Entire `listeners.JobListener` class (replaced by `ItemListener`)
* One form of `DirectoryBrowser` constructor
* One form of `Descriptor.configure()` (with `HttpServletRequest` param)
* `Descriptor.convert(Map)` and 4 implementations of this method, and code calling it in `Descriptor.readResolve()` (this code called `save()` whenever updating data, so there should be no remaining cases out there)

Alan's quest for removing deprecated code will likely continue for a while, but this is a good step in the right direction, keeping Hudson's internals in good working order. Worth mentioning, the influx of plugin releases in the [This Week in Plugins](https://jenkins.io/content/week-plugins-0) from a couple weeks ago, was driven largely by Alan, rummaging through the code of older plugins, updating plugins left and right.
<!--break-->
Now the breakdown for this release:

#### Bugs fixed
<ul class=image>
  <li class=bug> 
    Fix javascript problem showing test failure detail for test name with a quote character.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-1544">issue 1544</a>)
  <li class=bug> 
    Hudson can incorrectly configure labels for the master when bleeding edge EC2 plugin is used.
  <li class=bug> 
    Fixed the regression wrt the whitespace trimming caused by 1.346.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5633">issue 5633</a>)
  <li class=bug> 
    Under some circumstances, Hudson can incorrectly delete the temporary directory itself.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5642">issue 5642</a>)
  <li class=bug> 
    Newlines in MAVEN_OPTS environment variable can cause problems in other contexts.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5651">issue 5651</a>)
</ul>

<br clear="all"/>
#### Enhancements
<ul>
  <li class=rfe> 
    Improved the form validation mechanism to support multiple controls.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5610">issue 5610</a>)
  <li class=rfe> 
    Added message to slave log when it has successfully come online.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5630">issue 5630</a>)
</ul>


<br clear="all"/>
#### Contributors 
This release of Hudson contained 36 commits from **7** different contributors to "core":

* <a id="aptureLink_YFkDO3e779" href="https://twitter.com/abayer">abayer</a>
* <a id="aptureLink_TgMtrwa0Sz" href="https://twitter.com/_godin_">godin</a>
* <a id="aptureLink_BJgeHDF4sh" href="https://www.linkedin.com/in/thuybrechts">huybrechts</a>
* <a id="aptureLink_YaPunVjeFQ" href="https://twitter.com/kohsukekawa">kohsuke</a>
* <a id="aptureLink_XwoYyUAc5v" href="https://blogs.sun.com/mindless">mindless</a>
* <a id="aptureLink_IPwBJtA60V" href="https://twitter.com/ssogabe">sogabe</a>
* <a id="aptureLink_9NWuFKYOM9" href="https://twitter.com/wyukawa">wyukawa</a>



<br clear="all"/>
As usual, you can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.
