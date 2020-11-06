---
:layout: post
:title: Welcome to Hudson Labs!
:nodeid: 208
:created: 1276143624
:tags:
- general
- meta
- news
:author: rtyler
---
<img src="/sites/default/files/images/scientist.thumbnail.gif" align="right"/> Hello again! It's been a long time since I've written for the Hudson community, but now I'm back and ready to tackle some of the latest developments in the Hudson community. 


### What is Hudson Labs?

As you may have [read in April](https://jenkins.io/content/kohsuke-leaves-sun), Kohsuke left Oracle to found [InfraDNA](https://web.archive.org/web/20100612130510/http://infradna.com/), a company specializing around Hudson. The departure meant the Hudson community would no longer have access to some of the hardware and services that Kohsuke had accumulated over the years working on Hudson at Sun Microsystems. While we are still happily part of the [Java.net](https://java.net/) community, we've recognized the need for some community-owned resources and Hudson Labs was born.

Over the past couple months, a group within the Hudson community, "infra" (short for "infrastructure"), has been working to get machines set up and build the foundation for a more open Hudson project infrastructure.


### What does Hudson Labs provide?
<!--break-->
##### Builds

One of the first tasks we set upon when building out Hudson Labs was to start improving the build and release process of Hudson by moving as much of it into a [public Hudson instance](https://ci.hudson-labs.org). Building Hudson itself, plugins and dependencies of the Hudson project, the Hudson Labs instance will help improve the reliability of the Hudson ecosystem across the board, and should serve as a useful tool for core and plugin developers.


##### Mirroring

Thanks to the great team over at the [Oregon State University Open Source Lab](https://www.osuosl.org) (<a id="aptureLink_oz4HIIQKJD" href="https://twitter.com/osuosl">OSUOSL</a>), we've been able to build out [mirroring infrastructure](https://ftp.osuosl.org/pub/hudson/) for Hudson to provide fast access to native packages and wars alike. Currently the OSUOSL only has mirrors inside the continental United States, so we're reaching out to friends in Asia and Europe to extend the mirroring system.

##### Information

I'm currently working on re-working some of the blog posts you may have read over four months as more structured tutorials. I hope to provide an easily accessible knowledge-base for developing Hudson along with configuring Hudson for various platforms and development environments; this is a more difficult task so all the pieces aren't entirely in place for this just yet.


To be honest, I'm very enthusiastic about Hudson's future. Now that InfraDNA is up and running, Kohsuke's renewed focus combined with the foundation of Hudson Labs and the uncommonly hospitable Hudson developer and user communities, the future is looking bright!
