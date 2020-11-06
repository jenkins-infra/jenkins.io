---
:layout: post
:title: 'Hudson 1.348 Released '
:nodeid: 188
:created: 1267462399
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
The latest release, 1.348 of Hudson was pushed out to the repositories on the 26th of Feb. This release is primarily a bugfix release containing a number of fixes (listed below) and a few localization corrections

#### Bugs fixed
<ul class=image>
  <li class=bug> Fixed a performance problem of the job/build top page when there are too many artifacts.
<li>Improved /etc/shadow permission checks.
<li>DIsable auto-refresh in Groovy script console (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5729">issue 5729</a>)
</ul>


<br clear="all"/>
#### Contributors 
This release of Hudson contained 19 commits from **5** different contributors to "core":

* <a id="aptureLink_TgMtrwa0Sz" href="https://twitter.com/_godin_">godin</a>
* <a id="aptureLink_YaPunVjeFQ" href="https://twitter.com/kohsukekawa">kohsuke</a>
* swiest 
* manuel_carrasco
* rseguy


<br clear="all"/>
As usual, you can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.
