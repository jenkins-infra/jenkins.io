---
:layout: post
:title: Security warnings in Jenkins
:tags:
- core
- security
:author: daniel-beck
---
Jenkins 2.40 was released earlier this week, and readers of the [changelog](/changelog) will have noticed that it now includes the ability to show security warnings published by the configured update site.
But what does that mean?

In the past, we've notified users about security issues in Jenkins and in plugins through various means:
Emails to the [jenkinsci-advisories mailing list](https://groups.google.com/d/forum/jenkinsci-advisories) (which I recommend you subscribe to), blog posts, and, recently, emails to the oss-security mailing list.
But I still wanted to increase the reach of our notifications, to make sure Jenkins admins are informed quickly about possible security problems on their instances.
The logical next step was to include these notifications in Jenkins itself, and that feature has been added in Jenkins 2.40.

Today we enabled the publication of warnings on our update sites:
Once Jenkins 2.40 (or newer) refreshes its cache of update site metadata, it may now inform you that you're using a vulnerable plugin that should be updated or removed.
Right now, these aren't previously unknown warnings, but reference security advisories for plugin vulnerabilies that have been published over the past few years.

We will of course continue to publish security advisories using the mailing list of the same name, as well other means.

Stay safe!
