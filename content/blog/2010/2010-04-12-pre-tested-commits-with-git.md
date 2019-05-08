---
:layout: post
:title: Pre-tested commits with Git
:nodeid: 159
:created: 1271077200
:tags:
- infrastructure
- feedback
- jobs
- tutorial
:author: rtyler
---
At the first [Bay Area Hackathon](https://wiki.jenkins.io/display/JENKINS/BayAreaMeetup) in mid-2009, the topic du jour was "[pre-tested commits](https://wiki.jenkins.io/display/JENKINS/Designing+pre-tested+commit)." As potential implementations of the concept were discussed over burgers from <a id="aptureLink_gLlt1i6v1p" href="https://www.brickhousesf.com/">Brickhouse</a> in downtown San Francisco, we realized as a group a few things: first, those burgers were *delicious*, but more importantly: pre-testing commits is very-SCM dependent and involves a lot of moving parts. One of the positive changes that came out shortly after the meet up was the support for "Concurrent Builds", allowing a job to be executed concurrently on different slaves, a precursor to pre-tested commit support. Fervor for the pre-tested commit feature lowered as time went on, the feature being too dependent on the SCM itself was generally accepted as the reasoning behind the feature languishing.

Chances are the feature is in fact too large for Hudson to support alone. It requires Hudson, the SCM and likely a third tool to work in concert together to perform such a feat. 

With Git, and the phenomenal code review tool [Gerrit](https://code.google.com/p/gerrit/), and the [Gerrit plugin](https://wiki.jenkins.io/display/JENKINS/Gerrit+Plugin) by intrepid plugin developer, [Jyrki Puttonen](https://twitter.com/jyrkiputtonen), pre-tested commits with Hudson, Git and Gerrit *are* possible.
<!--break-->
For Git users more familiar with the distributed Git workflows, working with Gerrit should seem familiar. Gerrit has <a id="aptureLink_MoOPmIyV3m" href="https://www.eclipse.org/jgit/">JGit</a>, a Java implementation of Git embedded within it, along with an `sshd` stack, meaning Gerrit can masquerade as a "regular" Git remote repository. Developers can push and pull to the repository just as they can with any other Git repository (provided they have permissions of course). I won't delve too much into using Gerrit specifically here, but the pre-tested workflow with Gerrit and Hudson would look something like this:

* Dev creates a topic branch to work on a change
* Code is written (and hopefully tested) and committed locally
* Dev pushes commit(s) to Gerrit
* Hudson job (set to Poll SCM) picks up the patch, runs the job and marks it as "+1 Verified" or "-1 Fails"
* If the job fails or is unstable, the change should be reworked or corrected (typically with <a id="aptureLink_YL8glbfS7G" href="https://www.kernel.org/pub/software/scm/git/docs/git-rebase.html">git-rebase(1)</a>)
* If Hudson says the change is good to go, it can be cherry-picked or pulled directly from Gerrit.

For example:
<center><a href="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/gerrit_patch.png"><img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/gerrit_patch.png" width="520"/></a></center>

To learn more about Gerrit, check out the [project page on Google Code](https://code.google.com/p/gerrit/); information on the Gerrit plugin can be [found on the wiki](https://wiki.jenkins.io/display/JENKINS/Gerrit+Plugin).


----
