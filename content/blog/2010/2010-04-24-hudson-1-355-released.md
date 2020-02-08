---
:layout: post
:title: Hudson 1.355 Released
:nodeid: 154
:created: 1272111900
:tags:
- development
- feedback
- just for fun
- links
- releases
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_street.jpg" align="right" hspace="3" width="150"/> The release of 1.355 came out earlier this week but I hadn't had the chance to write anything up about it. Of course, the work never stops on Hudson so we almost have 1.356 ready to roll out the door, but then Kohsuke tweeted this:

> Because of the data center migration going on, I won't be able to release #hudsonci today.

I won't go into details on some of the infrastructure changes we have lined up just yet, so here's the breakdown of 1.355
<!--break-->
#### Bugs fixed
  <li class=bug> 
    Colored ball image at top of build pages was broken for Hudson in some web
    containers (fixed by removing workaround for a Firefox bug fixed since 3.0.5/Dec2008).
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-2341">issue 2341</a>)
  <li class=bug> 
    Console page while build is running did not wrap lines when viewed in IE.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5869">issue 5869</a>)
  <li class=bug> 
    Fixed build history to indicate test failure for MavenBuild and MavenModuleSetBuild.
  <li class=bug> 
    Make <tt>dropdownList</tt> work in repeatable content, such as a build step.
  <li class=bug> 
    Fixed a bug where a job created via XML didn't properly receive upstream/downstream computation.
    (<a href="https://n4.nabble.com/Hudson-API-td1747758.html#a1747758">report</a>)
  <li class=bug> 
    Argument masking wasn't working correctly for commands run on slaves
    (<a href="https://n4.nabble.com/Password-masking-when-running-commands-on-a-slave-tp1753033p1753033.html">report</a>)
</ul>


#### Enhancements
<ul>
  <li class=rfe> 
    Added the slave retention strategy based on a schedule.
  <li class=rfe> 
    Added to configure charset option of Mailer.
</ul>





----

You can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
