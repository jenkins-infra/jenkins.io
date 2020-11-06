---
:layout: post
:title: What JVM versions are running Jenkins?
:nodeid: 642
:created: 1446581989
:tags:
- general
- just for fun
:author: rtyler
---
Preceding some of last week's [Jenkins 2.0](https://wiki.jenkins.io/display/JENKINS/Jenkins+2.0) discussions, there had been [some threads](https://groups.google.com/d/msg/jenkinsci-dev/sw_WepGw0Pk/0gO2V9UXy-8J) on whether we should move Jenkins to require Java 8. The introduction of [Java 8](https://www.oracle.com/events/us/en/java8/index.html) last year brought performance improvements and highly desirable API changes, which make developing Java-based applications (arguably) much easier than before. The release was followed earlier this year by the [end-of-life announcement](https://www.java.com/en/download/faq/java_7.xml) for Java 7; the writing is on the wall: upgrade to Java 8.

I wanted to answer the question "does it even make sense to force an upgrade to Java 8?" There are plenty of technical discussions that we can have in the community on whether or not this is the right approach, but my goal was to try and measure the current Jenkins install base for Java 8 preparedness.

<!--break-->

While we do not currently (to my knowledge) collect Java runtime versions in our [anonymous usage statistics](https://stats.jenkins-ci.org/jenkins-stats/), we do have access logs from our [mirror redirector](http://mirrors.jenkins-ci.org) which might provide some insight.

With some access logs data, I went through the millions of requests made to Jenkins infrastructure in 2015 and started filtering out the user agent which made those requests.

> **NOTE:** This data is totally not scientific and is only meant to provide a coarse insight into what versions of Java access Jenkins web infrastructure.


When Jenkins hits the mirror network, it's not overriding the default user agent from the Java runtime, so many of the user agents for the HTTP request are something like `Java/1.7.0_75`. This indicates that the request came from a Java Runtime version 1.7.0 (update 75). 

Looking at the major JVM versions making (non-unique) requests to Jenkins infrastructure we have:


<center><img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/major-jvm-versions.png"/></center>

* **1.8.0**: 21,278,960
* **1.7.0**: 27,340,214
* **1.6.0**: 4,148,833

This breaks down across various updates as well, which is also particularly interesting to me because many of these Java versions have long since had security advisories posted against them.

<center><img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/jvm-versions-with-updates.png" width="600"/></center>


As I mentioned before, this is not a rigorous analysis of the access log data and is also not filtered by unique IP addresses. What I found most interesting though is that the Java 8 upgrade numbers are actually *fairly strong*, which I didn't expect. I expect that piece of the pie will continue to grow. Hopefully so much so that we're able to move over to Java 8 before the end of 2016!
