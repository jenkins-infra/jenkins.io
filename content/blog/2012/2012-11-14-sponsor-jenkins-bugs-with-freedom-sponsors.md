---
:layout: post
:title: Sponsor Jenkins bugs with Freedom Sponsors
:nodeid: 406
:created: 1352923793
:tags:
- development
:author: kohsuke
---
(This is a guest post by Tony França)

<div style="float:right">
<img src="https://jenkins-ci.org/sites/default/files/images/FS_vertical_logo_colored_512x347.png" width="128" height="87">
</div>

Hi all, my name is Tony, I'm the creator of ([FreedomSponsors](https://freedomsponsors.org/)) and today I want to talk how Jenkins has inspired me to build it.

Before starting, I'd like to thank the Jenkins crew for letting me publish this guest post in their blog.
On top of that, thank you for maintaining Jenkins as well - I'm a big fan and a heavy user. Jenkins potential to make peoples lives easier is really amazing.
You guys are amazing.
And Kohsuke, you're my personal hero :-)

All right, that being said, let's move on with the story.

Most people who like FreedomSponsors probably don't know that Jenkins is sort of the reason it exists in the first place. That's right, if it wasn't for Jenkins I'd probably never had the idea for FS.

This is how it happened.

I was playing with the ([Jenkins OpenID plugin](https://wiki.jenkins-ci.org/display/JENKINS/OpenID+plugin)), and I was having some trouble with it.
After a little research, I found that there was a JIRA bug for it - ([JENKINS-9216: Make OpenID work with Google Apps accounts](https://issues.jenkins-ci.org/browse/JENKINS-9216)).

"Bummer" - I thought - "Maybe I can try to debug it. Oh boy, but I don't know anything about Jenkins code. That would be too... expensive! I bet there are a few people out there that would be willing to even pay a few bucks to the Jenkins crew to prioritize this."

The moment I thought that, a storm of ideas came rushing into my head.
It was like a conversation with myself in my mind.

- "Wait a minute... why can't people actually do just that?! They should be able to."
- "Maybe a JIRA plugin could let them..."
- "But what about other projects, ones that don't use JIRA?"
- "Maybe there could be a central place for all those offers. If many people 'sponsor' the same issue, the developer who solve it might get a decent piece of gold - rightfully deserved. That could even free up more of their time to work on the projects they love :-)"
- "The sponsors would pay the developers out of gratitude, and for the sake of keeping their word."
- "This has the [Agile](https://agilemanifesto.org/) spirit in it: Customer collaboration over contract negotiation"

And I kept thinking, and it didn't took very long until I had the whole "sponsoring model" in my head.
I realised that that was one of the best ideas I had in my life. I was very excited and I had to act on it.

I started studying [Django](https://www.djangoproject.com/) on that same day. I had already learned some Python before and Django had been on my queue for some time. And I'm glad I did it. I've been building JavaEE (Java web) applications for about 8 years now, and, oh boy, Django makes things soooo much easier, and simpler, and faster to code - I'm in love with it... Okay, but I'm missing the point here.

So, I started building "it" alone on my free time. It took me a few days to pick a name for "it".
The "FreedomSponsors" name came very naturally - it rightfully conveys what the platform would do, and the spirit of software freedom that I'd like to encourage.

Seven weeks later it was done. I had already bought the domain and created an account at Amazon AWS.
So I put it up and started bugging everyone about it.
And guess who was the first person I wanted to tell? Kohsuke Kawaguchi :-)
It was just fair. So I sent him this email.

> On Sun, Jul 8, 2012 at 3:36 AM, Tony França <tonylampada@gmail.com> wrote:
> 
> Hi Kohsuke.
> My name is Tony, I'm a Software Architect.
> I'm a big fan and a (very) heavy user of Hudson - Jenkins.
> It has really been enabling our company to move towards a "continuous delivery"-like development process in the past couple of years.
>
> So, thank you for that.
>
> Also, if it wasn't for Jenkins, maybe I would never had the idea to build the FreedomSponsors web site.
> That's my personal project - an idea that I had about six weeks ago.
>
> You see, most of the time I was developing it, I had you in mind.
> I have always felt that "Jenkins is so great, that Kohsuke really deserves to get rich for it".
>
> I just launched FreedomSponsors - a few minutes ago.
> It just felt right to come here and tell you about it :-)
>
> Let's see if I can get you rich now :-).
>
> Cheers!
> Tony Lâmpada

And his reply just made my day

> On Thu, Jul 12, 2012 at 5:19 PM, Kohsuke Kawaguchi <kk at kohsuke dot org> wrote:
>
> Congratulations for launching your service.
>
> I thought about a similar idea long time ago over a lunch with my colleagues, but my hats off to you for actually making it real. I can imagine a lot of obstacles (most of those you already note in FAQ), but if this works out I think it'd be great.
>
> By the way, I wonder if you have considered open-sourcing this, say under Aflo GPL. With the network effect and being the dominant contributor, it's very difficult for anyone else to run the same code on public internet to compete with you, and it does let other people contribute small changes, and given your audience is open-source developers, I think it sends the right message as well as help you boost your development. It also seeds the ecosystem (of Bugzilla plugin, JIRA plugin, dashboard, etc.), too.
>
> Just my 2 cents.

You see, FS's code was still closed when I launched it. I was worried about competition indeed.
But his arguments were very convincing. Specially when he talked about sending the right message to the Free Software community. I thought about it for while and came to the conclusion that he has absolutely right. It still took me a few weeks until I moved [the code to Github](https://github.com/freedomsponsors/www.freedomsponsors.org). I'm glad I did it. The feedback loop has been great.

And that was not his only contribution. He also gave us this very useful piece of feeback:
([JIRA plugin to link from tickets to FreedomSponsors](https://freedomsponsors.org/core/issue/12/jira-plugin-to-link-from-tickets-to-freedomsponsors))

Indeed, that was a great idea. My friend and associate Arthur is the one who built it.
Kohsuke suggested that I joined the Jenkins crew at the ([Jenkins Governance meeting](https://wiki.jenkins-ci.org/display/JENKINS/Governance+Meeting+Agenda)) to see if everyone would agree about installing it on Jenkins JIRA. Everyone liked the idea and had no ojections.

I can't say enough how trilled and honored I felt knowing that Jenkins would be the first project to install our plugin. Thank you folks. Thanks Kohsuke. You guys are awesome :-)

Now FreedomSponsors is growing, slowly but steadily. And what makes us really happy is that almost every developer we tell about it just loves the idea. We've received valuable, constructive feedback from a lot of people who want to see us moving forward. That's the best incentive that I could wish for.

We still have a lot of challenges ahead of us. The biggest and closest one in the horizon is to start a "movement" that will help spread within companies a culture of contributing more to the free software projects they depend on, by making they realise that that's what's best for everyone. If we can achieve that then we'll have made the free software world even better.

So, everything I wrote so far is, hopefully, only the begginning of this story. And I'm really excited and looking forward to see it unfold. Being a part of it is even more exciting.

What about you? If you want to be updated about, or even help write the next chapters, then
[join](https://freedomsponsors.org/core/login/), [follow](https://twitter.com/freedomsponsors), [like](https://www.facebook.com/freedomsponsors), [read](https://web.archive.org/web/20130310041955/https://blog.freedomsponsors.org/), [spread the word](https://twitter.com/intent/tweet?hashtags=freedomsponsors&original_referer=http%3A%2F%2Fblog.freedomsponsors.org%2F&source=tweetbutton&text=Check%20this%20out!%20FreedomSponsors%20-%20Crowdfunding%20Open%20Source%2C%20one%20issue%20at%20a%20time&url=http%3A%2F%2Fwww.freedomsponsors.org&via=freedomsponsors), give [feedback](https://freedomsponsors.org/core/feedback) and [contribute](https://github.com/freedomsponsors/www.freedomsponsors.org) with code or new issues.

Thank you Jenkins crew, thank you Kohsuke.
We wouldn't have made it here without you.
