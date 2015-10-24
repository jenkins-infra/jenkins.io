---
layout: post
title: Our Role in the Java.net Community
nodeid: 222
created: 1278271824
tags:
- general
- guest post
- meta
---
A few weeks ago, when we first [launched the Hudson Labs](http://www.hudson-labs.org/content/welcome-hudson-labs) site, I expressed the need for Hudson to maintain some of our own architecture in order to continue to move forward:

> While we are still happily part of the Java.net community, we've
> recognized the need for some community-owned resources and Hudson Labs
> was born.

The thought of what Hudson Labs, and in turn Hudson's role within the Java.net community has been weighing on my mind over the past week or two. Java.net at it's core, as far as the Hudson project has been concerned, is a "forge". Similar to SourceForge, Berlios and Google Code, Java.net provides a number of fundamental services for open source projects: Subversion repositories, mailing lists, project pages, bug tracking, and so on. Outside of these "forge" services, Java.net is a collection of hosted projects, weblogs and [communities](http://www.java.net/community). I consider Java.net to be the home of "important" Java projects, at least those that aren't part of the Apache Software Foundation, projects like [Glasshfish](https://glassfish.dev.java.net/), [Netbeans](http://www.java.net/netbeans) or [OpenJDK](http://www.java.net/open-jdk).

A number of the "forge" facilities Hudson has outgrown as a project, we've left Java.net's Bugzilla-Collabnet-hybrid for our own instance of JIRA running at [issues.hudson-ci.org](http://issues.hudson-ci.org). Our project pages are hosted externally, we also have (through Hudson Labs) external hardware for running things like Hudson ([ci.hudson-labs.org](http://ci.hudson-labs.org)) and native package repositories for distribution ([pkg.hudson-labs.org](http://pkg-hudson-labs.org)). We do still use Java.net for our Subversion repository (Hudson Labs does have [an AnonSVN mirror](http://www.hudson-labs.org/content/mirrors) though), and our primarily `users@` and `dev@` mailing lists.
