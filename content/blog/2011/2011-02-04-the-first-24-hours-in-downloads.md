---
:layout: post
:title: The first 24 hours in downloads
:nodeid: 278
:created: 1296831600
:tags:
- infrastructure
- just for fun
:author: rtyler
---
As I had mentioned in [a previous post](https://jenkins-ci.org/content/installing-plugins-has-always-been-easy-now-its-fast-too) back when Jenkins was called something else, who can remember what anymore, I spent a lot of time working on a mirroring network. With our departure from any and all Oracle infrastructure, this mirroring network has now become our sole distribution mechanism for pushing out **all** releases and **all** plugins, in short, **lots and lots of bits**.

Just how much data are we now distributing through the Jenkins mirror network? 

<strong><big>Over 52GB in 24 hours</big></strong>

Here's the following in terms of a loose breakdown of the number of files served over the past day:

 * 788 `.war` 
 * 447 `.deb`
 * 290 `.rpm`
 * 1759 `.hpi` (plugins)


We're off to a great start! I'd like to extend my thanks again to the [OSUOSL](https://www.osuosl.org) and [XMission](https://mirrors.xmission.com) for their help getting the Jenkins mirrors functional as soon as possible
<!--break-->
