---
:layout: post
:title: Building Jenkins plugins with Gradle
:nodeid: 363
:created: 1325689200
:tags:
- development
- core
- meta
- plugins
- jenkinsci
:author: abayer
---
<img src="/sites/default/files/images/gradle_logo.gif" align="right" width="170"/>

Until now, Jenkins plugins written in Java or Groovy could only be built with Maven, using the maven-hpi-plugin to generate a proper manifest and archive which Jenkins can consume. But starting now, you can also use [Gradle](https://gradle.org)! 

See [the wiki](https://wiki.jenkins-ci.org/display/JENKINS/Gradle+JPI+Plugin) for information on how you can use Gradle and the new gradle-jpi-plugin to build, test and release your Java or Groovy Jenkins plugin.
