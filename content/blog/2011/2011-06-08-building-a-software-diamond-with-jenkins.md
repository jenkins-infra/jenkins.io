---
:layout: post
:title: Building a software diamond with Jenkins
:nodeid: 311
:created: 1307552667
:tags:
- general
- guest post
- plugins
- tutorial
:author: rtyler
---
[**Editor's Note:** *This is a guest post from Jenkins community member [Tom Rini](https://www.linkedin.com/in/tomrini)*]

Alternatively: **How to make your parallel jobs kick one last job at the end**


Many of us have had occasion to think: "*I could make this project build quicker if I could just run parts in parallel and then one final job to wrap it up.*"

Well, good news! Jenkins is here to help!  With the [Join Plugin](https://wiki.jenkins.io/display/JENKINS/Join+Plugin) you can do just that.  Over on the confluence page it’s got a number of examples and fancy flow charts.  But the take-away is that if you can describe the flow, you can make it happen.  But you’re saying "wait, I need to pass information around between the jobs."

We’ve got that one covered for you too with the [Parameterized Trigger Plugin](https://wiki.jenkins.io/display/JENKINS/Parameterized+Trigger+Plugin).  And here’s the best part, these two can work together!  With both plugins installed you can follow the steps listed in the Build Parameters section of the Join Plugin.

<center><a href="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/join_trigger.png" target="_blank"><img alt="Click to enlarge" title="Click to enlarge" src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/join_trigger.png" width="540" /></a></center>

And as they say, *now you're cooking with gas!*
