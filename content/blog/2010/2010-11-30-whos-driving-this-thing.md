---
:layout: post
:title: Who's driving this thing?
:nodeid: 268
:created: 1291120200
:tags:
- general
- core
- jenkinsci
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/health-60to79.gif" align="right"/>There's been a lot of discussion on the [new mailing lists](https://hudson-labs.org/content/new-hudson-mailing-lists) as of late regarding some of the infrastructure and ownership of the Hudson project. In case you haven't been following along at home, I'll try to catch you up as impartially as possible.


The Facts
----------

 * **2009.06.02**: After substantial problems with Java.net infrastructure, the
   [dev community discusses new infrastructure
   options](https://hudson.361315.n4.nabble.com/On-the-future-of-Hudson-hosting-and-infrastructure-td393278.html),
   including SourceForge, Google Code, Kenai, Berlios, GitHub, etc. Instead of
   moving the entire project, some key components such as the
   [issues.hudson-ci.org](https://issues.hudson-ci.org) are moved off of
   Java.net. Discussions about moving source code off of Java.net and onto other hosts like
   GitHub come up almost every four months on the mailing lists, typically
   coinciding with serious Java.net downtime or reliability issues..
 * **2010.11.01**: A discussion occurs on the developers mailing list about
   adding [Winston Prakash](https://twitter.com/wjprakash), the Oracle engineer re-assigned to replace [Kohsuke Kawaguchi](https://twitter.com/kohsukekawa) (Hudson
   founder/lead developer), as a co-owner to the Java.net project. Winston
   mentions that his question was driven by Oracle management who felt he should
   "co-own the project." After a round of discussion, it's decided by the devs
   list that it's acceptable and grants Winston co-ownership of the project as a
   sign of good faith from the community towards Oracle.
 * **2010.11.17**: [Andrew Bayer](https://twitter.com/abayer), core contributor
   and maintainer of numerous plugins emails the users and devs list with a
   proposal to move the mailing lists off of Java.net which has had notorious
   reliability issues within the Java ecosystem and was scheduled for a series of
   downtimes and migrations over the coming weeks. Google Groups is selected as the
   most reasonable by the community.
 * **2010.11.19**: Hudson project is lumped into the same Java.net migration bucket as Glassfish. Emails are sent to project owners, the users and the developers list. The mail to users and developers never arrives due to the sender not being subscribed. Both project owners (Kohsuke, Winston) miss the message, leaving the Hudson community in the dark regarding the pending migration.
 * **2010.11.22**: Shortly after midnight, Jacob Robertson reports that his
   SVN credentials no longer work, Kohsuke informs the developers list that the project is
   locked due to the migration, SVN is inaccessible and mailing lists fail shortly after that. <img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/health-40to59.gif"  align="right"/>The Hudson Java.net project
   begins its migration from the legacy infrastructure to the newer
   Java.net infrastructure (formerly known as "Kenai"). A group of core Hudson
   community members accelerate the move to Google Groups, pushing out
   announcements via [this
   blog](https://hudson-labs.org/content/new-hudson-mailing-lists) and
   [twitter](https://twitter.com/hudsonci) hoping to keep as many members in the
   loop as possible.
 * **2010.11.23**: Frustrated by the locking down of Hudson's source code,
   which sees between 3-8 commits to "core" a day, not counting the 300+
   plugins, Kohsuke [proposes moving to
   GitHub](https://groups.google.com/group/hudson-dev/browse_thread/thread/8d3cf0ca1240280a)
   on the new developers mailing list. The general consensus amongst the plugin
   and core developers was to go forward with moving to GitHub, no major
   objections were raised by the developer community.
 * **2010.11.27**: After Thanksgiving, Andrew Bayer submits the "[formal
   proposal](https://groups.google.com/group/hudson-dev/browse_thread/thread/c935a4740af0b920)"
   for migrating over to GitHub, Sets a deadline of the following tuesday
   (2010.11.30) for raising any major objections before "flipping the switch."




The Monday morning prior to the planned switchover to GitHub, Oracle Senior VP
of Tools and Middleware [Ted
Farrell](https://www.oracle.com/us/corporate/press/Spokespeople/016474) sent [a
message to the users list](https://groups.google.com/group/hudson-users/msg/cf0d72a7d97f2438) expressing concerns he had regarding the migration of
the Hudson codebase from Java.net to GitHub:
<!--break-->
> <em>Oracle's goal is to grow the community and make hudson stronger.  You
> all might not be aware of this, but the actual hudson user base is
> very large.  Much bigger than what you see on the mailing lists or in
> the forums.  The unfortunate part of that is how many of these users
> do not contribute to the core, and do not participate in these
> discussions.  They want to do that, but don't feel like they can be
> heard.  We want them to be heard.  We need to make the hudson
> community a place that will welcome all the hudson users and encourage
> its growth and longevity.  We will be announcing some changes in the
> upcoming weeks that we believe will foster that.
>
> For now, however, we are going to stay on the java.net
> infrastructure.  We believe it is important for hudson to stay
> connected with the rest of the the java community, as well as take
> advantage of some of the cool changes we will have coming to
> java.net.  Moving to GIT can be done while staying on java.net.  It is
> not a requirement to move to github.
>
> ...
>
> Because it is open source, we can't stop anybody from forking it.  We
> do however own the trademark to the name so you cannot use the name
> outside of the core community.  We acquired that as part of Sun.  We
> hope that everyone working on hudson today will do as they claim to
> want, and work with us to make hudson stronger.</em>


(Ted's message was rather long, you can read the [whole
post here](https://groups.google.com/group/hudson-users/msg/cf0d72a7d97f2438))

As one might expect, Ted's response to the thread was received with
mixed responses ranging from general confusion to obvious frustration.

Long time contributor to Hudson's Git plugin, [Nigel Magnay](https://github.com/magnayn) tried to clarify the benefits of migrating to GitHub instead of using Git on the "new" Java.net as succinctly as possible:

> <em>Just having git support != git support on github. They work full time on
> providing the best community development tools; I doubt kenai could even
> catch up, let alone surpass what they're doing.
> 
> ...
>
> I'm confused.
> 
> What things are you saying you will not let the Hudson developer community
> do?
> 
> I.E: Are you saying that, as the holders of the Hudson 'name', you are
> prohibiting the developer community from choosing (for ourselves) to migrate
> the infrastructure (bug tracking / wiki)? The repositories ?
> 
> So far the response from the developers has been pretty strongly in favour
> of the migration to google groups for mail, to github for code repositories
> and collaboration, and to a self-hosted site for bug tracking and
> information.</em>

<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/health-20to39.gif" align="right"/>
Ted's response to Nigel contained one of the most important nugget of
information for the whole discussion nestled in the middle of [the message](https://groups.google.com/group/hudson-users/msg/5540655e05ef2982):

> <em>Nigel, what I am saying is that I believe the *final* decision of what
> to do w.r.t. infrastructure belongs to Oracle and that decision should
> be made according to the will of the community as it makes sense</em>


The part where I editorialize
-----------------------------

I readily admit, there is a lot of information to take in here, for clarification there are two distinct "communities" involved in Hudson:

 * **developers**: the *hundreds* of developers actively communicating on the
  [developers list](https://groups.google.com/group/hudson-dev) and
  contributing to the 300+ plugins
 * **users**: tens of thousands of individuals and companies using Hudson
   either as a straight `.war` file, or using the native packages provided by
   the community

The fundamental issue here is that the **developers** want to make a change in
how *they* contribute to Hudson, and have made their voices heard to that end.
From the users' perspective, such a change would have literally **zero** impact
on them, which makes Oracle's conflation of the two sides of Hudson
particularly frustrating.

Part of the impasse between Oracle management and the developer community lies
in an inherent meritocracy in any large open source project, whether it be the
Linux kernel, the Python language and runtime, or the PostgreSQL database
server, those that contribute carry more weight within the community
**because** they are actively pushing things forward. On top of that, Oracle
continues to cite a "larger community" that's apparently larger than those
active committing to Hudson on a daily or weekly basis, without naming names or
citing specific contributions.


Ted, and in turn, Oracle's approach to the Hudson community seems to stem from
a systematic misunderstanding of how most (if not all) major open source
projects operate. Mentiong closed-door meetings between Sonatype and Oracle
regarding "how to make Hudson better" do nothing to aid many developers'
concerns about Oracle's commitment to Hudson as an open source project or a
community.


In my humble opinion, we are being told one thing while Oracle's actions speak
to another. Insisting that Hudson development remain on Java.net, after the
development community committed to GitHub, contradicts the words promising to
work with the Hudson community and to help facilitate its growth. Asserting
that Oracle isn't trying to exert unwelcome control over the project, while
doing exactly that.



Personally, I do want Oracle to continue to be involved, along with CloudBees,
Sonatype and many other companies that contribute to the ever-growing Hudson
ecosystem. The involvement of a plethora of different companies only helps
emphasize the importance of Hudson to the developer community and underline the
value of Hudson as a community owned and operated project.


December will be an interesting month, stay tuned.

----
