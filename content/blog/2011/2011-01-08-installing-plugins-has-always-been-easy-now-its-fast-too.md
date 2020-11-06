---
:layout: post
:title: Installing plugins has always been easy, now it's fast too!
:nodeid: 272
:created: 1294530206
:tags:
- general
- core
- news
:author: rtyler
---
As one of the "men behind the scenes" of the Hudson project, a lot of my contributions tend to be in writing articles or handling infrastructure, anything to ensure folks like [Kohsuke](https://twitter.com/kohsukekawa) can continue to make Hudson great without being distracted by inane system administration tasks. This past week, one of my long-running infrastructure projects has finally "gone live," making downloads of plugins and packages faster than ever!

Some number of months ago I became frustrated with the download speeds reported by our international users, while the majority of Hudson's infrastructure is all colocated inside of the United States, there is a **huge** number of Hudson users and developers who are both in Europe and Asia.

After discussing things with some of the folks that run [download.opensuse.org](https://download.opensuse.org), a [MirrorBrain](https://mirrorbrain.org) powered redirector, I set out to build something similar. A mirroring network which could be easily managed and help direct users' downloads to the geographically closest and fastest mirror available.


#### Where are we mirrored?

Currently we have mirrors in a few locations within the United States, and one overseas:

  * Southwest U.S. (Utah) - *Thanks to [XMission](https://www.xmission.com)*
  * Midwest U.S. (Chicago) - *Thanks to the [OSUOSL](https://www.osuosl.org)*
  * Northeast U.S. (New York City) - *Thanks to the [OSUOSL](https://www.osuosl.org)*
  * Germany - *Thanks to [aragost Trifork ag](https://www.aragost.com/)*

#### Using the mirrors

If you've updated or installed plugins from within Hudson lately, guess what! You're already using mirrors! In fact, since we flipped the switch on January 7th, over **800** plugins and **600** `hudson.war` updates have been downloaded from the mirroring network!
<!--break-->
If you'd like to download directly from the mirrors, you can browse on over to [mirrors.hudson-labs.org](https://mirrors.hudson-labs.org), which will redirect your request for specific files to the appropriate mirror based on your IP address. It's just that easy!


We are currently working with more providers to add additional mirrors, hopefully we'll have an Asian mirror online within the next two weeks and if we're lucky, we'll find some more European mirrors too.

----


I would like to thank the **immensely** helpful and supportive engineers over at the [OSUOSL](https://www.osuosl.org) for offering gratis tech support, suggestions, and bandwidth to serve as our *primary* mirror.

----
