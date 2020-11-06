---
:layout: post
:title: Performance improvements in 1.346
:nodeid: 199
:created: 1266333900
:tags:
- development
:author: rtyler
---
From time to time, we get a report of out of memory problems in Hudson. It's frequent enough that <a href="https://wiki.jenkins.io/display/JENKINS/I'm+getting+OutOfMemoryError">we have a dedicated Wiki page</a> that talks about how to obtain information to help devs work on the problem.

So <a href="https://n4.nabble.com/Restarting-hudson-every-day-memory-leaks-td1311161.html">the latest thread</a> from <a id="aptureLink_RTb6QLKuCh" href="https://www.linkedin.com/in/davidwoon">David Woon</a> was assumed to be one of those ordinary trouble-shooting sessions, but thanks to Gustaf Lundh, it turned out to be a very interesting exercise.

What we discovered was that the profiler I was using (<a id="aptureLink_VKTrt70n5i" href="https://www.yourkit.com/">Your Kit Profiler</a>), was basically eliminating all the weak/soft references from the picture entirely. If we are looking for leaks, this was the right thing, as those references will be cleared before VM chokes with <tt>OutOfMemoryError</tt>. But because of this elimination, I was completely blind to the wasteful memory usage in Jelly, which are only reachable via soft references.

So I used <a href="https://www.eclipse.org/mat/">Eclipse Memory Analyzer</a> and YJP side by side to look into Jelly's memory usage, and based on that insight, I was able to substantially improve the memory usage and speed of Jelly.

I monitor my production Hudson deployment with <a href="https://java.sun.com/performance/jvmstat/visualgc.html">VisualGC</a>, and the result was quite noticable. And I hope you'll notice that the response from Hudson is also snappier.

All these changes are a part of the latest 1.346 release.

----
**Editor's Note:** Kohsuke Kawaguchi a senior engineer at Oracle (formerly Sun) and is the founder and author of the Hudson project. To learn more about Kohsuke, you can [follow him on Twitter](https://twitter.com/kohsukekawa) or subscribe to [his blog](https://weblogs.java.net/blog/kohsuke/).
<!--break-->
