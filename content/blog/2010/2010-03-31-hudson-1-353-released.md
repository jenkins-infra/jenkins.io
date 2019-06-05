---
:layout: post
:title: Hudson 1.353 Released
:nodeid: 164
:created: 1270038000
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_soap.jpg" align="left" width="170" hspace="4" vspace="4"/> This week's release comes slightly later than usual and is mostly a clean-up of a few bugs. Due to a problem with the Kohsuke's [GitHub mirror](https://github.com/kohsuke/hudson) of Hudson's core, I can't mine the commits for interesting information as per usual so you'll just have to trust that Hudson 1.353 is chock full of good, wholesome bug fixes. If the problem persists next week, I'll find a better way to dig up information on particularly releases that doesn't depend on the GitHub mirror.


<br clear="all"/>
#### Bugs fixed
<ul class=image>
  <li class=bug>
    Tagging a repository can result in NPE. 
  <li class=bug>
    Fix possible form submission error when using multiple combobox elements.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-6025">issue 6025</a>)
  <li class=bug>
    Better escaping of test case names in test results pages.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5982">issue 5982</a>)
  <li class=bug>
    Make radio buttons work in repeatable content, such as a build step.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-5028">issue 5028</a>)
  <li class=bug>

    Fixed the handling of verifying that the POM path entered for Maven projects exists.
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-4693">issue 4693</a>)
</ul>

#### Enhancements
<ul>
  <li class=rfe>
    Added link to builds in buildTimeTrend
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-3993">issue 3993</a>)
</ul>


----

You can go grab the [latest .war file](http://mirrors.jenkins.io/war-stable/latest/jenkins.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.

----
