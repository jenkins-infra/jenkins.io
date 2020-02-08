---
:layout: post
:title: 'Call for Testers: The older the better'
:nodeid: 185
:created: 1267591779
:tags:
- development
- core
- jenkinsci
:author: rtyler
---
A couple weeks ago in the [post outlining the release of Hudson 1.347](https://jenkins.io/content/hudson-1347-released/) I mentioned that Alan Harder (a.k.a. mindless) had undertaken a deprecation-crusade; that is to say Alan has taken it upon himself to rid Hudson's code-base, particularly in the plugin area, of older code. One of Alan's branches `old-data-monitor` was merged into trunk with `r28147` bringing with it some changes to help migrate older plugin datasets to newer formats. 

When I reached out to Alan earlier today on IRC (`#hudson` on the <a id="aptureLink_C8savgu6dL" href="https://en.wikipedia.org/wiki/Freenode">Freenode</a>) about the subject he agreed that polling the community for beta testers would be a good idea; **this is where *you* come in**. Per Alan's message to the `dev@` mailing list:

> Visit your "Manage Hudson" screen to see if the notice about old/unreadable data appears. I'll be curious to see which of the old deprecated data structures are actually out there in people's XML files.

Instead of waiting for the release candidate to be packaged Wednesday evening, I've gone ahead and published the artifact from [build #4544](https://hudson.glassfish.org/view/Hudson/job/hudson-trunk/4544) which can be downloaded here: [hudson.war](https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/hudson_build4544.war)

If you have an **old** Hudson installation with, testing this build would be incredibly useful. Alan went on to say:

> If people find issues with OldDataMonitor, they should file them at [issues.hudson-ci.org](https://issues.hudson-ci.org) in "core" component and assign them to "mindless".

This change does not mutate any data (or at least it shouldn't) so it should be safe, be on the look out for exceptions in Hudson's log on startup.
