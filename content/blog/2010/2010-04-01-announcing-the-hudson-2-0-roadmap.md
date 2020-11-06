---
:layout: post
:title: Announcing the Hudson 2.0 Roadmap
:nodeid: 161
:created: 1270129800
:tags:
- just for fun
- meta
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/java-evil-edition.png" align="right"/>There have been numerous discussions on the [mailing lists](https://wiki.jenkins.io/display/JENKINS/Mailing%20List) over the past couple months regarding memory issues, speed regressions and a number of other issues regarding performance of Hudson, particularly under high load. In an effort to address these concerns, the Hudson core team has [announced](https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/just-kidding.jpg) a roadmap for **Hudson 2.0**.

In a [message](https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/just-kidding.jpg) to the `dev@` mailing list, Kohsuke said of Hudson 2.0:

> As it stands now Hudson 1.0 is a good proof of concept, it's time to take the lessons learned and build a truly solid enterprise-ready continuous integration server
<!--break-->
Some notable points from Kohsuke's announcement with regards to the Hudson 2.0 roadmap, which is expected to ship late Q4 2011, are:

* Implementation of `core` in portable C for greater speed and code readability
* Selection of a better license, namely the <a id="aptureLink_WU0wj407g6" href="https://en.wikipedia.org/wiki/WTFPL">WTFPL</a>
* Revamped storage architecture around the [Oracle 11g Database](https://www.oracle.com/database/standard_edition.html) to provide more optimal synergy over flat XML files.
* Embedding the Mono, Python, V8 and Lua engines allowing plugins to be written in C#, Python, JavaScript or Lua.
* Adoption of the Hudson [Eagle](https://randomfunnypicture.com/wp2/wp-content/uploads/2009/12/haters-gonna-hate-eagle.jpg) as a mascot instead of the butler
* "Social" support will be merged into `core`, integrating Hudson directly with Facebook so you can share test failures with your friends.

Hudson 2.0 is expected to follow in the intrepid footsteps of other major revamps such as [Netscape 5](https://en.wikipedia.org/wiki/Netscape_5) and <a id="aptureLink_LVKY9sDfJM" href="https://en.wikipedia.org/wiki/Perl%206">Perl 6</a> in its ambitiousness and innovation.

----
