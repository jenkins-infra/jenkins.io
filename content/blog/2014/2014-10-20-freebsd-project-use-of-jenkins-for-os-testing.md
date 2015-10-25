---
:layout: post
:title: FreeBSD project use of Jenkins for OS testing
:nodeid: 514
:created: 1413821550
:tags:
- general
- feedback
- guest post
:author: kohsuke
---
This is a guest post by Craig Rodrigues

---

The [FreeBSD project](http://www.freebsd.org) produces a modern operating system derived from [BSD Unix](http://en.wikipedia.org/wiki/Berkeley_Software_Distribution).

In the past 6 months, we have set up Jenkins at [http://jenkins.freebsd.org/](http://jenkins.freebsd.org/), to continuously build FreeBSD as developers add new code to the project. This has helped us identify and fix build breaks very quickly.

We have gone even farther by integrating Jenkins, [Kyua](https://github.com/jmmv/kyua#readme),
and [Bhyve](http://bhyve.org/).
[Kyua](https://github.com/jmmv/kyua#readme) is a testing framework for infrastructure software.
[Bhyve](http://bhyve.org/) is the native hypervisor that comes with FreeBSD (similar to KVM on Linux).

We use the [Build Flow plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Flow+Plugin) in this [example Build flow](https://jenkins.freebsd.org/jenkins/view/FreeBSD_src_stable/job/FreeBSD_stable_10/848/BuildGraph/)	 to do the following:

1. Build the FreeBSD kernel and userland on amd64 whenever someone checks in new code to http://svn.freebsd.org
2. Create a bootable FreeBSD disk image with [makefs](https://www.freebsd.org/cgi/man.cgi?query=makefs)
3. Boot the image under bhyve
4. Run these commands inside the bhyve VM:

```
    cd /usr/tests; kyua test; kyua report-junit --output=test-output.xml
```

5. Shut down the bhyve VM
6. Imports test-output.xml into Jenkins.
7. Produces a [full native test report in Jenkins](https://jenkins.freebsd.org/jenkins/job/FreeBSD_stable_10-tests/4/testReport/)

The results of this work were presented at the [Bay Area FreeBSD Users Group](http://bafug.org)
in [this presentation](http://www.slideshare.net/CraigRodrigues1/kyua-jenkins) in October 2014.

Jenkins has been very easy to set up and use under FreeBSD.   We hope that by using
Jenkins to run OS-level unit tests, we will be able to improve the quality of FreeBSD.
For further information, please feel free to contact us at <freebsd-testing@FreeBSD.org> .
