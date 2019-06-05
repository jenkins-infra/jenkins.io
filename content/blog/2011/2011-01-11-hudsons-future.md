---
:layout: post
:title: Hudson's future
:nodeid: 273
:created: 1294754400
:tags:
- general
- core
- meta
- news
- jenkinsci
:author: abayer
---
First, my apologies for the lack of updates on the [Hudson/Oracle situation](https://hudson-labs.org/content/whos-driving-thing) for
the last few weeks. While talks have been ongoing, the holidays have slowed
things down, and we didn't want to send out information that would later turn
out not to be true. We've been waiting for the talks to reach a resolution -
and I believe they now have.

Since the [java.net](https://www.java.net) migration problems, Oracle and representatives from the
Hudson community have been involved in talks on the future of the project in a
number of areas. The Hudson representatives have been [myself](https://twitter.com/abayer), [Kohsuke
Kawaguchi](https://twitter.com/kohsukekawa), and [Sacha Labourey](https://twitter.com/SachaLabourey)  (CEO of CloudBees and Kohsuke's boss), who was
brought in to help provide experience with discussions on a corporate/executive
level which neither Kohsuke nor I have, with Alan Harder and [R. Tyler Croy](https://twitter.com/agentdero)
advising on the side.

These talks have in many ways been fruitful - we came to working agreements
with Oracle on the project infrastructure (such as mailing lists and SCM
repository location), code review policy for Hudson core, and perhaps most
significantly, a governance structure for the project going forward. Some
issues are not yet entirely resolved, such as questions on restrictions on
third party dependency licenses. But one issue, which we feel is the most
significant issue of all, one for which we now believe no resolution is
possible: the rights to the name **Hudson**.

Oracle has told us that they have trademark applications filed in both the EU
and US for Hudson, based on Hudson's creation by Kohsuke while working at Sun.
The problem is that this trademark ownership gives Oracle the ability to revoke
the Hudson project's right to call itself Hudson at any time, and while Oracle
has made an attempt to offer some guarantees (most notably, that binary
releases of Hudson, once they've been released with the name Hudson attached,
will always retain the right to the name), they are not offering any binding
guarantee that the Hudson project will be able to retain its use of the name in
perpetuity.

Therefore, to continue using the name Hudson means ceding some of the project's
independence to Oracle - if the project and its governance board opted to go in
a direction Oracle disapproved of, Oracle would be able to take away the naming
rights. Or, in a less dramatic scenario, Oracle could insist on certain changes
to the code, infrastructure decisions, process, etc, regardless of opposition
from the Hudson development community, in order to retain the rights to the
name. 

In short, we'd be living under a sword of [Damocles](https://secure.wikimedia.org/wikipedia/en/wiki/Damocles), regardless of the goodwill
of the individuals we've been negotiating with at Oracle - Hudson as a project
would be beholden to Oracle's whims for its continued use of its own name, and
we believe that's not viable.
<!--break-->
As I see it, the only viable option facing the project now is to rename it, in
order to free it from the burden of Oracle's ownership of its name. This is not
a first choice, not by a long shot, but I don't see any other choice available
to us that would preserve the integrity of the project going forward. Oracle
will be presenting their proposal for the project continuing under their
umbrella - I encourage you to read it when it becomes available and weigh it
accordingly. I'll just focus on what Kohsuke, other prominent Hudson community
members and I have endorsed.

### The Proposal

First, we rename the project - the choice for a new name is **Jenkins**, which we
think evokes the same sort of English butler feel as Hudson. We've already
registered domains, Twitter users, etc for the new name, and have done our best
to verify that there are no existing trademarks which would conflict with it.
Kohsuke will be registering the trademark for Jenkins in his name, with the
intent of transferring ownership of the trademark to the umbrella of the
[Software Freedom Conservancy](https://www.sfconservancy.org/) once the Jenkins project has been admitted to it
(which, I should add, is very much our plan, hopefully in their next round of
new projects in a few months - we've already had preliminary contacts with
SFC). We still invite Oracle to remain involved with the project, on equal
terms with all other contributors, and hope they'll take us up on this
invitation.

Second, out of respect for Oracle's trademark claim on Hudson, we will move our
infrastructure off of Oracle-owned and hosted servers, and we will rename
existing independent components of the infrastructure to no longer use "Hudson"
- i.e., mailing lists, Github repos, etc. This would be a gradual process,
obviously. 

Third, we will put in place an interim governance board for the project,
consisting of three members - myself, Kohsuke and, if Oracle elects to remain
involved, Winston Prakash, the Oracle engineer working on Hudson. The interim
board members will serve for the next 3-6 months, until the governance
structure can be nailed down securely enough to hold elections for the board
members.

Obviously, such a move could not be undertaken without the agreement and
support of the Hudson community. We believe this proposal is the best choice
for the project in the situation it's currently in, but we aren't closing off
discussion, questions, etc, and we encourage your feedback and comments. If
there's anything you need clarified, please ask and we'll do our best to
answer.

Once Oracle's proposal is available later this week (hopefully Wednesday,
possibly Thursday, from what I've been told), which I strongly advise you all to 
read and consider, we'll be putting up a poll to determine the position of the 
community. Once that vote is done, assuming the consensus is to rename, we'll 
put the mechanisms in motion and switch over as fast we can.

There may be some confusion as to whether we're proposing to fork Hudson, or
rename the existing project. I firmly believe we are proposing the latter - for
me, the project's key component is Kohsuke himself. If the community decides to
support renaming the project to Jenkins, and Oracle chooses to continue
development themselves under the name Hudson, they are, obviously, entirely
welcome to do so. But with Kohsuke working on Jenkins, that's the true home and
the future of the project for me, regardless of the name.

----
