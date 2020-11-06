---
:layout: post
:title: Hudson 1.372 sets sail
:nodeid: 238
:created: 1282050000
:tags:
- general
- news
- releases
:author: rtyler
---
Last Friday the Hudson team rolled out a small 1.372 with two enhancements following the **critical** [1.371 release on Monday](https://jenkins.io/blog/2010/08/10/big-security-fix-hudson-1-371-released/). Not a whole lot to say about this release other than go get it!

#### Enhancements

<ul class=image> 
  <li class=rfe> 
    Persist matrix-based security settings in a consistent order
    (<a href="https://issues.jenkins-ci.org/browse/JENKINS-7138">issue 7138</a>)
  <li class='major rfe'> 
    Jobs can now use boolean expression over labels to control where they run.
</ul>
<!--break-->
----

You can go grab the [latest .war file](https://ftp.osuosl.org/pub/hudson/war/1.372/hudson.war) straight from our [OSL mirror](https://www.osuosl.org) or if you're using a native package, use your package manager to upgrade.
