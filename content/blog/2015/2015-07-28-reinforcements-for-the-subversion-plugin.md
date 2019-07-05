---
:layout: post
:title: Reinforcements for the Subversion Plugin
:nodeid: 590
:created: 1438114001
:tags:
- development
- guest post
- plugins
:author: daniel-beck
---
*This is a guest post by Manuel Recena Soto (aka recena).*

Users of the plug-in know that it has undergone [very important changes](https://wiki.jenkins.io/display/JENKINS/Subversion+Plugin#SubversionPlugin-ChangeLog) in the last two years.

Unfortunately, some of these changes resulted in regressions for some users that weren’t properly addressed in subsequent releases. Many users were therefore forced to keep using an older release of the plugin to keep their instances running.

To fix this difficult situation I've decided to dedicate my spare time to improving the plug-in and attempting to restore the stability that an essential plug-in like this requires. 

In order to do so, [me](https://github.com/recena/), my colleague [Steven Christou](https://github.com/christ66) and other members of the community have drawn up a plan.

In the coming weeks we will be focusing our efforts on:

* Going through the Jira tickets
  * Checking whether they are duplicated
  * Checking whether they are still relevant
  * Asking for more information from the people who reported them
  * Establishing their priority
* Reviewing pull requests
* Investigating bug reports and try to reproduce them
* Fixing serious bugs
* Refactoring the plugin to improve its maintainability.

We’re planning to publish a new 2.5.x bugfix release once a fortnight. We are not considering the inclusion of new features or improvements. The priority now must be to obtain a stable and reliable plug-in, one that will allow us to take things up again in the future with greater security and peace of mind.

*Interested in helping? Just send us a message!*
