---
layout: post
title: "Jenkins 2.0-alpha-3 Preview Build has been released!"
tags:
- jenkins2
author: daniel-beck
---

We just published the new Jenkins 2.0-alpha-3 preview build.

## What's new?

* **Jenkins is now secure out of the box**:
  Administrators previously had to set up authentication and authorization while Jenkins was accessible to anyone on the same network.
  Now, Jenkins is protected out of the box, so that it is always safe from unauthorized access.
* **Plugin selection for setup**:
  We refined the plugin selection on the setup dialog.
  You've always wondered why Jenkins does not install the Git Plugin by default?
  Now it does, along with a number of other plugins popular in the Jenkins community.
  We're also including more plugins complementing the [Pipeline Plugin](/solutions/pipeline/):
  The [Pipeline Stage View](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Stage+View+Plugin) plugin lets you quickly see what's going on in your CD pipeline, and the [GitHub Organization Folder Plugin](https://github.com/jenkinsci/github-organization-folder-plugin#github-organization-folder) will automatically scan your GitHub organization for repositories with Jenkins Pipeline definitions, and set up jobs for those.
* **Redesigned job configuration forms**:
  The job configuration form has been redesigned so its structure is visually clear when showing complex configuration forms.
  Additionally, the tabs on the top of the page show where you are, and can be used to quickly navigate between the different sections of the configuration form.

## Download now!

[Get Jenkins 2.0 alpha 3 now](/2.0/), and tell us what you think:

If you use Twitter, you can leave us some feedback [on Twitter](https://twitter.com/intent/tweet?text=@jenkinsci%20I%20think%20%23jenkins2%20is%20).

Our [jenkinsci-users](http://groups.google.com/group/jenkinsci-users/topics) mailing list is also available for feedback in [this thread](https://groups.google.com/d/msg/jenkinsci-users/fEWFVUj0UVY/GbG0ChvkIgAJ).

And of course, since this is a preview release, if you find any issues please report them on our [issue tracker](https://wiki.jenkins-ci.org/display/JENKINS/Issue+Tracking) to the *JENKINS* project.

## Known issues

* Some plugins with dependencies to previously bundled plugins fail to load or work correctly.
Install Mailer Plugin, Matrix Project Plugin, JUnit Plugin, and Maven Integration Plugin from the Plugin Manager and restart Jenkins.
* The configuration forms sometimes fail to apply the new design and tabbed navigation. If this happens, just reload the page.
