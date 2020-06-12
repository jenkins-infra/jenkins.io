---
:layout: post
:title: 'Spotlight on: ITA Software'
:nodeid: 147
:created: 1265895000
:tags:
- general
- feedback
- interview
:author: rtyler
---
For the first "User Spotlight" interview *ever* on Continuous Blog, I am talking with Matt Girard of 
<a href="https://itasoftware.com/?continuousblog" target="_blank">ITA Software</a>, a Boston-based software company that produces travel industry software which is used by many of the major carriers in the U.S. and abroad. When I sent out [a message](https://twitter.com/hudsonci/status/8553593409) asking for users of Hudson in the corporate space to ping me about doing a "spotlight" on them, ITA Software stuck out in particular; they're hiring a Hudson expert!

<a style="margin: 0pt auto; padding: 0px 6px; text-align: center; display: block;" id="aptureLink_oQPlXrRBHE" href="https://twitter.com/equalize/status/8338991375"><img title="Tweet by Matthew Girard" src="https://placeholder.apture.com/ph/355x210_TwitterArticle/" style="border: 0px none ;" width="355px" height="210px"></a>


The format for the "spotlight" series isn't entirely nailed down yet so feel free to ask questions in the comments section and I'll follow-up with Matt after the fact if need be. That said, without further delay, Matt Girard from ITA Software, on Hudson.
<!--break-->
----

<table border="0">
<tr><td align="center">
<strong>Hudson</strong>
</td><td>
Matt, appreciate you taking the time to answer some questions about Hudson at ITA Software, let's start with a simple one: How long has ITA been using Hudson?
</td></tr>

<tr><td align="center">
<strong>Matt</strong>
</td><td>
My pleasure, glad to be a part of the community. We have been using Hudson in some form since early 2008. Predictably our usage has increased over time and now encompasses the majority of our automated build and test infrastructure.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<strong>Hudson</strong>
</td><td>
Was continuous integration a part of ITA's workflow prior to adopting Hudson? If so: what did ITA switch to Hudson from, and why?
</td></tr>

<tr><td align="center" valign="top">
<strong>Matt</strong>
</td><td>
Yes, though not to the degree that we have now. Prior to Hudson we were reliant on <a id="aptureLink_0DdF7ImGgA" href="https://en.wikipedia.org/wiki/BuildBot">BuildBot</a> for our automated builds, but we were not doing continuous integration
 across our components until after the transition to Hudson. The easy to understand UI and flexibility were primary features that compelled our switch. I should mention
 that when we decided to switch we also evaluated <a id="aptureLink_3DDvWBrYei" href="https://en.wikipedia.org/wiki/CruiseControl">CruiseControl</a> but Hudson came out on top for our needs.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<strong>Hudson</strong>
</td><td>
What kind of projects are you typically using Hudson for? What
languages/build system(s)? What platforms is Hudson performing builds? What kinds of jobs primarily run on ITA's Hudson cluster?
</td></tr>

<tr><td align="center" valign="top">
<strong>Matt</strong>
</td><td>
Our Hudson environments (yes, we have more than one) have been optimized for building C++, Java (all <a id="aptureLink_dkCKWMZxl1" href="https://en.wikipedia.org/wiki/Apache%20Maven">maven</a> based), Lisp (a surprise to some to be sure <a href="https://itasoftware.com/careers/l_e_t_lisp.html?catid=8" target="_blank">more about that here</a>), and Python on Linux build agents (Fedora and CentOS).

Our jobs are (loosely) grouped into one of three categories: rpm (we are primarily RedHat based), tests, and tools. The rpm jobs are the actual code builds and individual component unit tests. The test jobs (thank you <a id="aptureLink_ZDsnAh3cPt" href="https://plugins.jenkins.io/parameterized-trigger">parameterized trigger plugin</a>!) are part of a larger cross-component integration testing and promotion scheme. The (handful of) tools jobs support us in tasks such as cleaning up stale sandbox database connections.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<strong>Hudson</strong>
</td><td>
Given the flexibility of Hudson, it's safe to say that not everybody is using it in the exact same fashion, is there anything you would consider interesting or noteworthy about the use of Hudson at ITA?
</td></tr>

<tr><td align="center" valign="top">
<strong>Matt</strong>
</td><td>
I think that our most interesting usage of Hudson has to be how we have combined parameterized builds with the parameterized trigger plugin in order to do cross-component testing of trunk code. More specifically, we pass a properties file (to us a "scoreboard" that tells the jobs what exact revisions of which projects to
 test together) to several jobs and only build a final promotion job if ALL of downstream jobs (with the same scoreboard) passed. In this way we create a hurdle that all of our code must clear before we even consider deploying it anywhere else.


The next most interesting thing we are doing is using Hudson for continuous <em>deployment</em> of monitoring changes into our staging environment. It's quite rewarding to watch a check-in makes it's way through Hudson, into and rpm, and out to a server without a human being involved.
</td></tr>
<tr><td><br/></td></tr>

<tr><td align="center">
<strong>Hudson</strong>
</td><td>
Are there any additional tools ITA has written to better integrate things "behind the scenes"?
</td></tr>

<tr><td align="center" valign="top">
<strong>Matt</strong>
</td><td>
We evolved what became a very large build script (mostly derived from what we had for BuildBot) that handles all of the nitty-gritty details involved in the building, packaging, and testing of our software. Recently we have been working to refactor this into several smaller build tools each with a more focused purpose. The first of these is designed (largely as a wrapper to <a id="aptureLink_IpFANHwY8F" href="https://en.wikipedia.org/wiki/RPM%20Package%20Manager">rpmbuild</a>) to standardize our package building while leaving the .spec files (with the real specifics) living alongside the code where they belong.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<strong>Hudson</strong>
</td><td>
On a scale from 1-10, how important would you rate Hudson for ITA's
day-to-day workflow?
</td></tr>

<tr><td align="center">
<strong>Matt</strong>
</td><td>
ITA is a decent size company and there is plenty of work that goes on that does not involve Hudson in any way. Still since we rely on the building and testing that Hudson does in order to promote new code to production, I would say that we are somewhere around an 8.
</td></tr>
<tr><td><br/></td></tr>
</table>

----

I'd like to thank Matt again for being a good sport as the very first in what I hope will be a long line of "spotlights" on companies using Hudson to help them work smart, better and faster. If you would like to discuss your company's use of Hudson for Continuous Blog, you can contact me at `tyler` at `linux.com`


----
**Editor's Note:** Matt Girard is the Manager of Build and Integration at ITA Software and a passionate advocate for continuous integration and continuous deployment. He believes that release engineering exists to make developers lives easier -- not harder -- and can be found posting about such topics on Twitter as <a id="aptureLink_l9fKLQNx8b" href="https://twitter.com/equalize">@equalize</a>.
