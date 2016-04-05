---
layout: post
title: Jenkins 2.0 beta released
tags:
- jenkins2
author: daniel-beck
---

We released the Jenkins 2.0 beta earlier today. [Download it here and try it!](/2.0/)

Besides a number of bug fixes and minor improvements, the following changes are new since the last alpha preview release:

### Redesigned "New Item" page

We redesigned the "New Item" page. Item types now have icons to be more visually distinctive.

Additionally, item types can now define a category they belong to (such as "Project" or "Folder"). Once the complexity of the "New Item" page reaches a certain threshold, the item types will be grouped into categories to be easier to find. However, for now, it's unlikely that you will see these categories, as support for this mechanism will need to be added in plugins. This is a new API in core, and we invite plugin developers to support it to make Jenkins easier to use for users with a large number of item types. It doesn't even require raising the minimum supported Jenkins version.

### Separate configuration page for tools

The length and complexity of the *Configure Jenkins* page once a few dozen plugins are installed made it unnecessarily difficult to use. To improve that we're moving the tools configuration (Git, Maven, Gradle, Ant, etc.) out of that page, into the new *Global Tools Configuration*.

### Upgrade notice and plugin installer

The Pipeline plugin suite is a big part of Jenkins 2. Over the past few weeks, open-source plugins adding support for visualization (Pipeline Stage View), automatic GitHub project creation (GitHub Branch Source Plugin) and Bitbucket project creation (Bitbucket Branch Source Plugin) have been released. However, when upgrading from Jenkins 1.x, users weren't even given any information on these features.

To address this, users upgrading from Jenkins 1.x will now be shown a banner when they first log into Jenkins as administrator, offering them to install the suite of Pipeline plugins.

