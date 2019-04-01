---
:layout: post
:title: Hudson 1.354 Released
:nodeid: 158
:created: 1271421900
:tags:
- development
- feedback
- just for fun
- links
- releases
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/scenic_hudson.png" align="right" hspace="3"/>Hear ye, hear ye! Behold, the first release of Hudson *ever* made by a not-employed-by-Sun <a id="aptureLink_7UNdgyqEaS" href="https://twitter.com/kohsukekawa">Kohsuke</a> (as we [covered last week](https://jenkins.io/content/kohsuke-leaves-sun)). This iteration of Hudson contains only bug fixes, check the listing below for the specifics on which bugs have been fixed (1.355 is looking like it will contain a number of fixes as well). The release of 1.354 comes slightly later than usual given some of the logistics that needed to, or still need to be resolved.

One of the infrastructure issues that's half-way resolved is the question of Debian/Ubuntu packages. Kohuske has packages uploaded in an experimental [apt repository on hudson-labs.org](https://hudson-labs.org/debian/) which you can try out. That said, it's not entirely clear whether this is going to be the preferred means of distributing native Debian/Ubuntu packages in the future (your mileage may vary).
<!--break-->
#### Bugs fixed
<ul class=image> 
  <li class=bug> 
    POM parsing was still using the module root as the base for relative paths for alternate settings files.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6080">issue 6080</a>)
  <li class=bug> 
    Fix dynamic updates of build history table when <a id="aptureLink_MAx8CeZUo3" href="https://en.wikipedia.org/wiki/Cross-site%20request%20forgery">CSRF</a> protection is turned on.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6072">issue 6072</a>)
  <li class=bug> 
    Improved the error reporting mechanism in LDAP setting.
  <li class=bug> 
    Raw console output contains garbage.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6034">issue 6034</a>)
  <li class=bug> 
    Fixed a file handle leak in the slave connection.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6137">issue 6137</a>)
  <li class=bug> 
    Quiet period wasn't taking effect properly when doing parameterized builds.
</ul> 

<br clear="all"/>
### Contributors
The release of 1.354 contains a total of 51 commits to the "core" part of the tree, from 9 different contributors

* abayer
* drulli
* kohsuke
* manuel_carrasco
* mindless
* sogabe
* swiest
* vlatombe
* wyukawa
<br clear="all"/>

----

You can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
