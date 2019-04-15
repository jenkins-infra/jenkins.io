---
:layout: post
:title: Would you run Hudson in the cloud?
:nodeid: 195
:created: 1266932700
:tags:
- jenkinsci
:author: rtyler
---
One of my favorite bloggers on the subject of continuous integration, <a id="aptureLink_e9BNkKIorq" href="https://twitter.com/builddoctor">The Build Doctor</a>, posed this question in [a recent post](https://www.build-doctor.com/2010/02/23/continuous-integration-in-the-cloud-good-idea/):

> Continuous Integration in the cloud: good idea?

The topic of running a CI server in a virtualized environment, such as with <a id="aptureLink_nJiKPqGQ1T" href="https://en.wikipedia.org/wiki/Amazon%20Elastic%20Compute%20Cloud">Amazon's EC2 service</a>, is an interesting issue, particularly in the Hudson community. About 10 months ago Kohsuke [announced the Hudson EC2 plugin](https://weblogs.java.net/blog/2009/05/18/hudson-ec2-plugin) which has seen slow, but steady development since then, including support for the [Ubuntu Enterprise Cloud](https://www.ubuntu.com/cloud/private) which was added to the plugin in a release last Monday.

As The Build Doctor and his readers point out, continuous integration is a difficult task to offload into the cloud because of the immense hardware demands constant building and testing presents. That said, Hudson *does* very effectively manage spinning slaves up and down on demand if you've configured it as such. Implication being: running Hudson in the cloud may be more efficient to meet peak demands without needing to run a large farm of machines.<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_in_the_cloud.png" align="right"/>

If you're interested in trying out the [EC2 plugin](https://wiki.jenkins.io/display/JENKINS/Amazon+EC2+Plugin), check out <a id="aptureLink_6E30Ex9PTT" href="https://www.sonatype.com/">Sonatype's</a> post on [Nexus Open Source and Hudson on EC2](https://www.sonatype.com/people/2009/06/nexus-open-source-and-hudson-on-ec2/) might be a good start.

Would you run Hudson in the cloud?
