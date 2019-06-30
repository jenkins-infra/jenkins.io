---
:layout: post
:title: Jenkins Long-Term Support Release
:nodeid: 320
:created: 1308248657
:tags:
- general
- core
- releases
- lts
:author: kohsuke
---
We have released <a href="https://jenkins-ci.org/">1.409.1, our first long-term support (LTS) release</a>, from the Jenkins project.

The idea of the LTS release is to provide a second release line the favors more stability and bug fix only maintenance. This release line branches off from a bit old Jenkins release (in this case 1.409), and we will only put important backported bug fixes. We'll keep releasing 1.409.2, 1.409.3, and so on, as such bugs appear, and in several months (our current thinking is 3 months) we'll designate another release and repeat this process all over again. I think it provides more comfortable upgrade path for larger deployments. For more about this, <a href="https://wiki.jenkins.io/display/JENKINS/LTS+Release+Line">see Wiki</a>.

In large companies that use Jenkins in a large scale, there often is a team of people who looks at incoming Jenkins release, tests it with their environments and their plugins, and then let their internal group consume them. With this release line, I'm calling for them to join the effort on this branch. Vojtech Juranek from Red Hat is already helping us tremendously, so is Yahoo in choosing the base release line and backporting. But it'd be great to get more people on board, as I think it'll benefit everyone to have a larger number of eyeballs on the same code. You'll also have a say on what bugs need to be backcported, etc. If you are interested in this effort, please let us know.
