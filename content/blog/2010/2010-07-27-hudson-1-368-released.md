---
:layout: post
:title: Hudson 1.368 Released!
:nodeid: 231
:created: 1280239200
:tags:
- general
- core
- news
- releases
- jenkinsci
:author: rtyler
---
Regular readers will recognize that I've been slacking off quite a bit lately with my release announcements, my apologies. With the release of 1.368 on Sunday, which fixed a few fairly important bugs, I figured I'd dusty off my blogging fedora and give this a shot.

This release has three bug fixes in it which were causing some issues for some users, particularly those deploying Hudson inside the recently released [Tomcat 7.0](https://tomcat.apache.org/tomcat-7.0-doc/changelog.html) (see <a href="https://issues.jenkins-ci.org/browse/JENKINS-6738">issue 6738</a>).

Hudson users utilizing the [JDK auto-installation](https://wiki.jenkins.io/display/JENKINS/Tool+Auto-Installation) feature between different platforms may have been affected by <a href="https://issues.jenkins-ci.org/browse/JENKINS-6880">issue 6880</a> which was also fixed in this release.

Bringing up the rear is the fix to <a href="https://issues.jenkins-ci.org/browse/JENKINS-7004">issue 7004</a> which detailed a few discrepencies between the `/buildWithParameters` and the `/build` remote APIs.


If you're not affected by these issues, you may want to wait for the soon-to-be-released 1.369 which has **even more** juicy bug fixes in it (with a dash of enhancements) to upgrade.
<!--break-->
----

You can go grab the [latest .war file](https://ftp.osuosl.org/pub/hudson/war/1.368/hudson.war) straight from our [OSL mirror](https://www.osuosl.org) or if you're using a native package, use your package manager to upgrade.
