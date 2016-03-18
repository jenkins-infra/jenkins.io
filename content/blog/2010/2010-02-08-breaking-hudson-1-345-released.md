---
:layout: post
:title: "Breaking! Hudson 1.345 Released!"
:nodeid: 202
:created: 1265657763
:tags:
- development
- feedback
- just for fun
- links
:author: rtyler
---
As I mentioned in the footer of the post on the [Hudson 1.344 release](http://blog.hudson-ci.org/content/hudson-1344-released), there were a couple big regressions in the 1.344 release that were causing a number of users issues (such as [issue 5536](http://issues.hudson-ci.org/browse/HUDSON-5536) and [issue 5546](http://issues.hudson-ci.org/browse/HUDSON-5546)).

As a result, Kohsuke and the team have quickly pushed out a hot-fix release: 1.345. Here's the break down:

#### Bugs fixed:

* Update center retrieval, "build now" link, and real-time console update was broken in 1.344 ([issue 5536](http://issues.hudson-ci.org/browse/HUDSON-5536))
* Fixed the backward incompatibility introduced in HUDSON-5391 fix in 1.344. ([issue 5391](http://issues.hudson-ci.org/browse/HUDSON-5391))

If you have already updated to 1.344, your "Update Center" is most likely busted and you'll need to download the `hudson.war` file manually.

You can go grab the [latest .war file](http://hudson-ci.org/latest/hudson.war) straight from `hudson-ci.org` or if you're using a native package, use your package manager to upgrade.
