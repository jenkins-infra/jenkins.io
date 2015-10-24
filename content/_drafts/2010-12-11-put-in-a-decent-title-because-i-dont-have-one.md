---
layout: post
title: Put in a decent title because I don't have one
nodeid: 271
created: 1292093732
tags:
- general
- core
- mailing list
- meta
- news
- jenkinsci
---
While we don't yet have a final agreement on all details in place, there has continued to be a lot of progress in the talks with Oracle. A number of issues remain to be ironed out, and I've been asked not to go into detail on those, but I can update you all on the areas where we have reached consensus.
<!--break-->
As you saw if you're on the mailing lists, there was a vote this week as to whether to continue to use the Google Groups mailing lists, or move back to the new java.net mailing lists. This put the decision in the hands of the community, with the support of Oracle as well as the rest of the Hudson project's leadership. The result was clear - 162 votes for Google Groups, 10 for java.net mailing lists. So the Google Groups will remain the official Hudson mailing lists.

Besides the mailing lists, the other time-critical issue that impacts the entire Hudson community is source control. That has also been resolved, and in truth wasn't really an area of conflict, just confusion. Hudson's core is already on GitHub at https://github.com/hudson/hudson, and will remain there, with eventual plans to use Gerrit in front of the GitHub repo for code review, patch submissions, etc. Hudson's related tools, backend utilities and the like will also be moving to GitHub. Plugins, well, that's up to the plugin developers. Both the existing java.net SVN repo's plugins area and the Hudson GitHub organization will be "official" homes for plugins - we're not going to require that plugin developers use one or the other. Kohsuke is working on some issues in the migration tools we've been writing for moving existing plugins from SVN to GitHub, and once that's finished, we'll make an announcement on the dev mailing list that if any plugin developers wish to move their plugin(s) to GitHub, they should let us know, and we'll handle the move.

For the near future, at least, the wiki and issue tracker will remain as they are today. The plan is to end up moving the issue tracker to java.net's hosted JIRA setup, so we can avoid needing to maintain the existing separate server ourselves - we're making sure that the hosted JIRA setup will provide the functionality and performance we need to keep our existing processes in place, and the java.net team is helping. We're hoping that we'll eventually be able to move the wiki over to the java.net infrastructure too (which would hopefully get us away from the repeated outages/performance problems/etc we have with the existing wiki box/setup), but that'll require having Confluence available at java.net, so it's not yet clear whether that'll happen, or, if it does happen, when that would be.

I'd like to say that all the outstanding issues will be resolved in the next week, but that's probably overly optimistic. There are some complicated questions we're trying to answer, and, especially given the holidays, not everything can move as fast as we'd like. But I am confident that we'll be able to resolve the remaining issues, and that what we've agreed on so far resolves the big issues from the last few weeks, so that Hudson's users and developers can get back into their normal rhythms without concern. Thanks for your patience, and thanks for using Hudson. =)
