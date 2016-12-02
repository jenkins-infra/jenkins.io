---
:layout: post
:title: 'Summary Report: Git Repository Disruption Incident of Nov 10th'
:nodeid: 448
:created: 1385401054
:tags:
- infrastructure
- news
:author: kohsuke
---
As [reported](https://news.ycombinator.com/item?id=6713742) in [various places](http://www.reddit.com/r/programming/comments/1qefox/jenkins_developers_accidentally_do_git_push_force/), there was an incident in early November where commits in our Git repositories have become misplaced temporarily by accident. By the mid next week we were able to resurrect all the commits and things are back to normal now.


As there are many confusions and misunderstandings in people’s commentary, we wrote this post to clarify what exactly happened and what we are doing to prevent this.


## Timeline
In the early morning of Nov 10th 2013, one of the 680 Jenkins developers had mistakenly launched [Gerrit](http://code.google.com/p/gerrit/) with a partially misconfigured [Gerrit replication plugin](http://gerrit-documentation.googlecode.com/svn/Documentation/2.3/config-replication.html), while pointing Gerrit to his local directory that contains 186 Git repositories cloned from [the Github Jenkins organization](https://github.com/jenkinsci/). These repositories were checked out about 2 months ago and weren’t kept up to date. Gerrit replication plugin had then tried to “replicate” his local repositories back to GitHub, which it considers mirrors, by doing the equivalent of “[git push --force](https://www.kernel.org/pub/software/scm/git/docs/git-push.html)” instead of regular push. Unfortunately, Gerrit replication plugin defaults to a forced push, which is the opposite of what Git normally does. The replication also happens automatically, which is why this mistake has impacted so many repositories in such a short time.


As a result, these repositories have their branch heads rewinded to point to older commits, and in effect the newer commits were misplaced after the bad git-push.


When we say commits were "misplaced", this is an interesting limbo state that's worth an explanation for people who don’t use Git. A Git commit is identified by its SHA1 hash, and these objects will never get overwritten. So the misplaced commits are actually very much on the server intact. What was gone was the pointer that associates a human-readable branch name (such as "rc") to the latest commit on the branch.


By Nov 10th 12:54pm GMT, multiple developers had [noticed this](https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/qOAqXGaRioIJ), and within several hours, we [figured out](https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ) what happened. From Gerrit log files and with the help of GitHub technical support, he was able to figure out all the affected repositories, and later [an independent script](https://github.com/jenkinsci/backend-git-pushf-finder) was written to [verify the accuracy](https://groups.google.com/d/msg/jenkinsci-dev/Lj_mPb7jMmo/qf_pdQVBHZUJ) of this list.


Some of the Jenkins developers were closely following this development, and were able to restore branches to point to correct commits by simply pushing their up-to-date local workspaces back into the official repositories. Git makes it very easy to do this, and most of the popular plugins affected were restored in this manner within 24 hours.


At the same time, we needed to systematically restore all the affected repositories, to make sure that we have not lost anything. For this, we contacted GitHub and asked for their help, and they were [able to mostly restore branch heads](https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/6JVpAwau37AJ) to their correct positions. We have also independently developed a script to find out exactly what commits branch heads should be pointing to, based on the [GitHub events API](http://developer.github.com/v3/activity/events/) that exposes the activities to Git repositories. This script [found a dozen or so branches](https://groups.google.com/d/msg/jenkinsci-dev/Lj_mPb7jMmo/3N7AVQQed70J) that fell through the cracks of GitHub support, and we have [manually restored those](https://groups.google.com/d/msg/jenkinsci-dev/Lj_mPb7jMmo/1f9Bs2TILEQJ).


## Mitigation in the future
The level of support we got from GitHub and our ability to independently verify lost commits and subsequently restore them made us feel good about GitHub, and we have gained confidence in our ability to recover from future incidents.


That said, what happened was a serious disruption, and it’s clear we’d better prepare ourselves both to reduce the chance of accidents like this and increase the ability to recover. To that end, we hope GitHub would expose a configuration option to disable forced ref updates. They [already do this](https://enterprise.github.com/help/articles/disable-force-pushes) on GitHub Enterprise after all. Dariusz [pointed out](https://groups.google.com/d/msg/jenkinsci-dev/dD-sumd81pU/usnd7M77JvUJ) that CollabNet takes this one step further and offers [ability to track deleted branches, tags, and forced updates](http://blogs.collab.net/git/protect-git-history). Something like that would have made the recovery a lot easier.


We are going to make two improvements to our process so that we can recover from this kind of problems more easily in the future.


Firstly, we’ll develop a script that continuously records the ref update events across the GitHub Jenkins organization. This will accurately track which branch/tag is created/updated/deleted by who. In case of an incident like this one, we can use this log to roll back the problematic push more systematically.


Secondly, we’ll allow people to control access to individual Git repositories, as opposed to give them all or nothing access to the entire array of plugin repositories.


The Jenkins developers decided to continue the current open commit policy despite the incident to preserve [our culture](https://wiki.jenkins-ci.org/display/JENKINS/Governance+Document#GovernanceDocument-OurPhilosophy), which helped us navigate through this incident without a single argument nor flame war.


## FAQ

### Does everyone in the organization have full commit privileges to all the repositories?
Yes, with some exceptions. To encourage co-maintenance of plugins by different people, and to reduce the overhead of adding and removing people from our 1100+ repositories, we use one team that gives access to most repositories, and put committers in this team.


### I prevent forced push in my Git repositories. I’m safe from this trouble, right?
No, unfortunately something like this [can still happen to you](https://bugs.eclipse.org/bugs/show_bug.cgi?id=361707), as you can also accidentally delete branches. If you want to learn from our mistakes, you should definitely enable server-side [reflog](https://www.kernel.org/pub/software/scm/git/docs/git-reflog.html), to track ref updating activities. “git config core.logAllRefUpdates true” on the server will enable this.


### Can’t you just have people with up-to-date copy push their repos and fix it?
This is indeed how some of the repositories got fixed right away, where some individuals are clearly in charge and are known to have the up-to-date local repositories. But this by itself was not sufficient for an incident of this magnitude. Some repositories are co-maintained by multiple people, and none of them are certain if he/she was the last one to push a change. Many plugin developers just scratch their own itch and do not closely monitor the Jenkins dev list. We needed to systematically ensure that all the commits are intact across all the branches in all the affected repositories.


### Can’t you just roll back the problematic change?
Most mistakes in Git can be rolled back, but unfortunately ref update is the one operation in Git that’s not version controlled. As such Git has no general-purpose command to roll back arbitrary push operation. The closest equivalent is reflog, which offers the audit trail that Git offers for resolving those cases. But that requires direct access on the server, which is not available on GitHub. But yes, this problem would not have happened if we were hosting our own Git repositories, or using Subversion for example.
