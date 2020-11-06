---
:layout: post
:title: JRuby Branch merged!
:nodeid: 330
:created: 1312872249
:tags:
- development
- core
- jenkinsci
- ruby
- jruby
:author: cowboyd
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/jruby.png" align="right" width="150"/> Yesterday, [Kohsuke](https://twitter.com/kohsukekawa) [announced](https://groups.google.com/group/jenkinsrb/msg/32815b1ea917355d) that the 'jruby' branch of jenkins-core had been [merged to master](https://github.com/jenkinsci/jenkins/commit/f6373f7ada14a7914f4ae08b6af4c1b27d343c21).

This doesn't mean that we're done and that you can go forth and write pure ruby plugins... not by any stretch of the imagination. Instead, what it *does* mean, is that the Jenkins mainline is much more friendly to runtime analysis of classes with which it is not familiar.


## The problem

When analyzing plugin classes, Jenkins uses just about every kind of metadata you can think of to get information about them: Class name, Field names, method names, member modifiers, annotations, you name it. It even uses the containing class relationship for inner classes to match Descriptors with what they describe.

It's all a great example of convention over configuration (CoC). In fact, I've never really seen CoC implemented in a Java project before as successfully as it has been in Jenkins. Plugin authors don't have to duplicate any metadata that Jenkins can figure out for you -- and it's alot! The drawback though, is that extensions depend very heavily on conforming to the structure of a conventional Java class.

The changes in this merge, and in several of the modules on which Jenkins depends, allow more than ever to get this information by asking an object directly rather than querying its private class structure.

## The Kicker

Many of theses changes aren't even JRuby specific! While they do enable JRuby integration, They're really just making things more friendly for dynamic languages in general. So, in theory, it should pave the way for others like JavaScript and Python.

## Where now?

We're still working on the ruby runtime and tools which will provide as crisp a Ruby development experience as we can. I don't want to proffer an estimate of when those will begin to be useable, but it is important to mark this very important milestone and explain what it does and does not mean.

### We need you!

There is still much work to be done to enable a writing Jenkins plugins in Ruby, we are looking for people who know Ruby and feel like pitching in: writing Rake tasks, improving the glue layer, documentation, etc.

If you're interested, most of the action is happening on the [jenkinsrb@googlegroups.com](https://groups.google.com/group/jenkinsrb) mailing list, so join us!

----
<!--break-->
