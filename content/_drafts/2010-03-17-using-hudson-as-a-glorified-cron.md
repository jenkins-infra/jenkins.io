---
layout: post
title: Using Hudson as a glorified cron
nodeid: 155
created: 1268888110
tags:
- jobs
---
Cron is one of the oldest tools in the standard Unix toolbox, a simple utility for scheduling tasks on regular intervals. While straight-forward and fairly easy to understand, <a id="aptureLink_lKjpFXRnxV" href="http://en.wikipedia.org/wiki/Cron">cron</a> is over **thirty years old** and still has a number of problems:

* Poor indication of success/completion. Cron on most systems will send the user running it an email (to their local mbox) with the output of the task. Cron doesn't care about success or failure, it's sole purpose is to run your script and then sleep.
* Tasks are not queued, but rather fired at their specified intervals. For most tasks this isn't a particular problem, but issues can arise if a scheduled task takes so long to complete, rsyncing files over a slower link comes to mind, that the task is still running when the next interval comes around. Cron will start the new task and further tax resources already running the previous task.
* Tasks are isolated to the user who owns the crontab.; this can fall under a bug or a feature heading. The scheduling of tasks isn't "shareable" by a group of individuals, leaving many to sudo to a particular user responsible for certain tasks to update their scheduling in cron.
* Tasks are isolated to a specific machine, "distributed cron" systems such as [GNUbatch](http://www.gnu.org/software/gnubatch/) exist, but I personally find them not worth the effort to set up and maintain.

In all honestly, Hudson is at its core a glorified distributed scheduler sitting behind a snazzy web interface, making it a great Cron replacement for "serious business." Let's take the following usecase:

> For a while Engineer Bob has been the only analytics engineer working at TinyCorp.The company has been expanding rapidly, adding three more analytics engineers to work with Engineer Bob processing all the data from TinyCorp's production site.
>
> Not only is there *a lot* more data to sync from production to the Hadoop cluster, more people need to be aware of it. 


[run a Hudson slave via an init.d script](http://suereth.blogspot.com/2010/01/hudson-slave-agent-startup-script.html)
