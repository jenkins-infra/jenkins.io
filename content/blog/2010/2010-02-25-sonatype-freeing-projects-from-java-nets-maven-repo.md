---
:layout: post
:title: Sonatype freeing projects from java.net's Maven repo
:nodeid: 191
:created: 1267130700
:tags:
- core
- just for fun
:author: rtyler
---
Are you working on a project which uses java.net's <a id="aptureLink_L4MIM7mY1F" href="https://en.wikipedia.org/wiki/Apache%20Maven">Maven</a> repository for deploying its artifacts? 

Well, if so, there's a great opportunity opening up for you to get off that problematic repository: <a id="aptureLink_9b4lZR3Gq1" href="https://www.sonatype.com/">Sonatype</a> is <a href="https://www.sonatype.com/people/2010/02/java-net-maven-repository-rescue-mission-on-march-5th/">helping java.net projects move to Sonatype's hosted OSS Nexus repository</a>, starting March 5th. We're looking into moving Hudson over but for most smaller projects, this should be a no-brainer. Problems with the java.net Maven repository are legendary and Sonatype's OSS Nexus repository is a great alternative. 

Take a look and see if this can work for you.


----
**Editor's Note:** Andrew Bayer (`abayer`) has been a contributor to Hudson since early 2009, contributing to the ClearCase plugin, Hudson's core and a small number of other plugins. Andrew also helps Kohsuke with a lot of Hudson's project infrastructure, most notably the migration from Bugzilla on Java.net to JIRA running at [issues.hudson-ci.org](https://issues.hudson-ci.org).
