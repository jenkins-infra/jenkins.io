---
:layout: post
:title: 'Spotlight on: VisFleet'
:nodeid: 198
:created: 1266506100
:tags:
- general
- feedback
- interview
:author: rtyler
---
For this week's user spotlight, I'm talking to Rasheed Abdul-Aziz of
VisFleet Ltd. out of New Zealand. This being our second "spotlight" on a particular company, the format can still be considered *beta*; if you have any additional questions for Rasheed, feel free to ask them in the comments and I'll try to get Rasheed to answer.

Similar to the spotlight on ITA Software from last week, VisFleet builds business software helping their customers operate their businesses more effectively through web applications in tandem with mobile applications. While I could endlessly discuss the power and flexibility of Hudson, particularly for building web software, I'll let Rasheed do the majority of the talking, so let's get to it.
<!--break-->
<table border="0">
<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
Rasheed, thanks for talking with me today, I think I did a poor enough job
introducing <a id="aptureLink_qn9wDVslnL" href="https://twitter.com/visfleet">VisFleet</a>, would you mind explaining a bit more of what you guys do and some of the challenges it presents?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
It's a pleasure. VisFleet has changed it's direction somewhat, moving from
services into product development. As we move into product, we want to be
responsive to our customers. Agile development is becoming core to how we
operate, and as such, continuous builds and integration became a major
factor. We now plan to offer two products for work planning and and vehicle
tracking. We want to present these systems with a SaaS model. The world of
online, pay as you go software, has a culture of frequent improvements and
responsiveness to user feedback. If we want to do well in this space, it's
important that we can code, test, release and feed back in
tight iterations.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
How long has VisFleet been using Hudson?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
About 14 months now.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
Did you guys work with continuous integration prior to starting to use
Hudson? If so, what system was VisFleet using and what compelled the switch
to
Hudson?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
We didn't actually, but certainly everyone I knew who was doing continuous
integration recommended Hudson.

</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
That's good to hear! How lucky you are to know so many smart people :)<br/><br/>
What kinds of projects is VisFleet building with Hudson?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
We build and test Ruby On Rails service layer applications. We also build <a id="aptureLink_hbiB8O3Dwj" href="https://en.wikipedia.org/wiki/Adobe%20Flex">Flex</a> applications using the Flex SDK for our web-deployed RIA offering. Lastly, we build our iPhone applications using Hudson.
</td></tr>
<tr><td><br/></td></tr>

<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
I'd say building and testing web applications alone with Hudson would be quite notable, but to add Flex and iPhone applications into the mix as well is certainly interesting! Anything specific that's interesting about VisFleet's use of Hudson?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
It runs multiple slave types, and automates deploys to different cloud
infrastructures. At the moment we have 2 Flex build slaves running Ubuntu, A
Mac Mini building our iPhone app, and several Ubuntu Servers testing our web
tier. We currently deploy to Citrix Xen servers, and soon to <a id="aptureLink_Xq08IAbEb1" href="https://twitter.com/RackCloud">Rackspace Cloud</a> as well.
<br/>
<br/>
In the near future, we will automate integration by first updating an
integration system on the cloud, deploying our system and then running our
tests. All very quickly.
<br/>
<br/>
We have very little metric and reporting output from Hudson, and this is
noteworthy in it's absence. It's very important  to use to provide clear
development metrics and integrate those into our <a id="aptureLink_ZAd2AShPj0" href="https://en.wikipedia.org/wiki/Scrum%20%28development%29">Scrum</a>/<a id="aptureLink_U9x9KuaN08" href="https://en.wikipedia.org/wiki/Kanban">Kanban</a> approach. What
Hudson has done for us is educate us about the possibilities in
visualisation and reporting, and is informing the way we structure our
codebase going forward. Soon, we expect to have a premium test driven
development environment and workflow.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
We all know Hudson isn't perfect but there's a lot of room for extending it to meet your demands if need be, what additional tools have you written to glue everything together behind
the scenes?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
We are using '<a id="aptureLink_dcU0BLKBi3" href="https://rubyhitsquad.com/Vlad_the_Deployer.html">Vlad the Deployer</a>' and in legacy, '<a id="aptureLink_CMeh4NNwSI" href="https://www.capify.org/">Capistrano</a>' for a lot of
our deployment and build tasks. These are merely infrastructure specific
scripts to ensure we can bring up live environments in the shortest amount
of time possible.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
So it sounds like you guys are all on board with Hudson, on a 1-10 scale, how important would you rate Hudson's importance to VisFleet's workflow?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/visfleet_sm.png" alt="Rasheed @ VisFleet"/><br/>
<strong>Rasheed</strong>
</td><td>
7, aiming at 10. The missing points are just a matter of time :)
</td></tr>
<tr><td><br/></td></tr>
</table>

----

Thanks again to Rasheed for chatting with me about how Hudson helps VisFleet keep cranking on what they do best. If you would like to discuss your company's use of Hudson for Continuous Blog, you can contact me at `tyler` at `linux.com`



----
**Editor's Note:** Rasheed Abdul-Aziz is a Software Architect at VisFleet Ltd. Rasheed specializes in Flex RIA development, but also loves a good build script and manages Hudson for VisFleet. Find out more about VisFleet and Rasheed on the [VisFleet devblog](https://devblog.visfleet.com/) and [Rasheed's blog](https://squeedee.tumblr.com)
