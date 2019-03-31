---
:layout: post
:title: 'Update: Wiki and issue tracker outage'
:nodeid: 601
:created: 1439455436
:tags:
- infrastructure
:author: daniel-beck
---
[I recently wrote about the two day outage of our wiki and issue tracker](https://jenkins-ci.org/content/wiki-and-issue-tracker-outage-over-weekend):

> While this was a rather lengthy outage, it could have been much worse. We lost none of the data, after all.

[OSUOSL have since published their post mortem](https://osuosl.org/blog/mysql1-vip-outage-post-mortem/). I was *really* wrong about not losing any data:

> A further complication was that our backups were pointed at mysql2, which was out-of-date with mysql1, due to the initial synchronization failures. Fortunately, we had the binary logs from the 17th through the 30th. This means that though most data could be restored, some data from between the 15th and the 17th was lost.

For our issue tracker, that means that issues JENKINS-29432 to JENKINS-29468 were lost, as well as comments posted from about July 15 12:20 PM to July 17 2 AM (UTC). We know this thanks to the [jenkinsci-issues](https://groups.google.com/group/jenkinsci-issues/topics) mailing list where the lost issues and comments can be looked up for reposting.

We unfortunately don't have such a record from our wiki.
