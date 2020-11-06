---
:layout: post
:title: Resurgence of Releng
:nodeid: 165
:created: 1269952500
:tags:
- guest post
- jenkinsci
:author: rtyler
---
A few weeks ago I passed a job listing that I had found through one of my **many** Google Alerts for Hudson-related queries to Andrew (`abayer`), following up on one of those job listings Andrew recently signed an offer to join the nice folks over at Digg to be their resident "build guy." On its own I thought "great for Andrew!" and nothing more, then I saw [this thread](https://www.reddit.com/r/programming/comments/bi58m/anyone_here_a_build_engineer_or_part_of_the_build/) on reddit which poses the question:

> Anyone here a build engineer, or part of the build team? Could you please share your experience?

It seems, to me at least, the notion of "release engineering" is making a come-back, particularly in the aging "Web 2.0" world where companies like Digg, Facebook, Reddit, Twitter, etc are anywhere from five to ten years old. As these companies have aged a couple of important things have happened, their code-base has aged increasing the possibility of bitrot, but they have also expanded in terms of headcount. Start-ups that might have once slighted larger corporations like Oracle, Cisco VMWare and IBM for their burdensome process and longer release schedules now find themselves ensnared with massive code bases, larger development teams and complicated deployments. 



<center><a href="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_vs_buildbot.png"><img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_vs_buildbot.png" width="555"/></a></center>


Over the past few months we've seen Hudson being used in a number of different contexts, it was [pitched at PyCon](https://jenkins.io/content/hudson-pycon) as part of a larger appeal to the Python community to get on the continuous integration bandwagon, we've seen a few posts from developers using Hudson for testing and packaging [Android](https://jenkins.io/content/getting-started-building-android-apps-hudson) and [iPhone apps](https://manicwave.com/blog/2010/03/01/that-feels-better-cocoa-hudson-and-running-green/), .NET developers are [jumping on board as well](https://bobcravens.com/2010/03/01/getting-started-with-ci-using-hudson-for-your-net-projects/). Across the board it feels like Hudson is being more and more widely used, it is no longer the mainstay of the Java shop's toolkit, it's become a must have for *all* developers.

With the allure of [continuous deployment](https://timothyfitz.wordpress.com/2009/02/10/continuous-deployment-at-imvu-doing-the-impossible-fifty-times-a-day/) and Hudson's lowered barrier to entry for testing, packaging and automating releases, is release engineering making a comeback? 


----


