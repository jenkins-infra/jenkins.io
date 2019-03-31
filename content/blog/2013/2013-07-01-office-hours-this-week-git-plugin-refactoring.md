---
:layout: post
:title: 'Office hours this week: Git plugin refactoring'
:nodeid: 427
:created: 1372723508
:tags:
- development
- plugins
:author: kohsuke
---
This Wednesday's [Jenkins office hours](https://wiki.jenkins-ci.org/display/JENKINS/Office+Hours) is all about the Git plugin refactoring that's going on.

<div style="float:right; margin:1em">
<img  width="250" src="https://git-scm.com/images/logos/2color-lightbg@2x.png"/>
</div>

[Git plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin) is one of the most popular plugins out there, and it's been around for quite some time. Combine that with the fact that there are so many different ways to use Git, it was inevitable that Git plugin became quite a capable but complex plugin over time. It has more than a dozen options and switches, and it was becoming harder to use and harder to maintain.

As early as 2010, some of us have already been saying that we should refactor this plugin, but none of us have managed. The good news is, I finally started tackling this problem last month while I was in London, and I've made a steadily progress since then and I'm ready for a wider review.

So we'll spend this Wednesday going over the changes. I'll show you how the new version looks, what changes are made internally, and what it'll enable us in the future.

If the Git plugin is important to you, and you want to see what's cooking, please join us in [the office hours](https://wiki.jenkins-ci.org/display/JENKINS/Office+Hours) on Google Hangout.

Looking forward to seeing you!
