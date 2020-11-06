---
:layout: post
:title: Mirror, mirror on the wall
:nodeid: 328
:created: 1311001200
:tags:
- infrastructure
- news
:author: rtyler
---
Let me preface this entire post with this: **I love
[Contegix](https://contegix.com)**.

----

While working on some infrastructure tasks I had long-since put-off for the
Jenkins project, I noticed something this weekend that scared the hell out of
me.

At some undetermined time, our [MirrorBrain](http://mirrorbrain.org)
installation *stopped* redirecting to our mirror network. Absolutely **zero**
downloads were being redirected, meaning that `cucumber`, the 1U machine
graciously colocated by [Contegix](https://www.contegix.com) had served up
***far*** more bits than I ever wanted it to.

As such, I would like to publicly apologize to Contegix on behalf of the
Jenkins project. Their support for the project has been tremendous but
this glitch caused such an incredible amount of traffic to be pushed through
their network that I feel exceptionally bad about it (turns out, Jenkins is pretty popular!)



Now, for the good news. In diagnosing and debugging this issue (in a
caffeine-fueled frenzy I might add) I managed to do a couple things:

 * I corrected the redirection relatively easily
 * I fixed our long-standing geo-location issue, **finally enabling redirection to our european
   and asian mirrors!**

Within 30 minutes of correcting the error, I was able to add *two* mirrors in
Germany, re-enable one from Taiwan and add a new mirror in Japan!

<!--break-->

I'm hoping to add even more mirrors in even more regions as volunteers with
bandwidth step-forward, if you're interested in hosting a mirror you can drop
me a line at `tyler@linux.com`.

----
