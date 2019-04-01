---
:layout: post
:title: 'Spotlight on: SpringSource'
:nodeid: 192
:created: 1267108200
:tags:
- general
- feedback
- interview
:author: rtyler
---
For this week's user spotlight segment, I'm talking with <a id="aptureLink_FPwIok2zLS" href="https://twitter.com/dougmaceachern">Doug MacEachern</a> of <a id="aptureLink_3sE4QkWryf" href="https://www.crunchbase.com/company/hyperic">Hyperic</a>, part of <a id="aptureLink_Xv7fvWA2ED" href="https://www.crunchbase.com/company/springsource">SpringSource</a>, a division of VMware, hoping I got that dependency chain correct. Hyperic builds enterprise systems monitoring and management software and also contributes to a number of open source projects, many of which are built with Hudson. <a href="http://blog.hudson-ci.org/sites/default/files/hyperic_hudson.png" target="_blank"><img src="http://blog.hudson-ci.org/sites/default/files/hyperic_hudson.png" align="right" width="350" alt="A small subsection of Hyperic's Hudson"/></a>

To date I must say that Doug's use of Hudson is one of the largest and more impressive installations I've seen. I don't want to spoil the interview, but they're testing on platforms that don't even run *Java*. Madness! If you think you can out-do him, you can find my email information at the bottom of the interview, I'd love to hear about it!

Without further ado, Doug from SpringSource.
<!--break-->
<table border="0">
<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>Doug, can you tell us a little bit more about what SpringSource is using Hudson for? How long has SpringSource been using it?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>
We started using Hudson in early 2008 to automate the build and testing of our <a href="https://sigar.hyperic.com/">SIGAR library</a>.  The SIGAR API implements a portable interface in C for gathering system information related to memory, processors, file systems, network interfaces, network connection tables, the process table and more.  We support dozens of OS + version + architecture combinations, along with several language bindings.  SIGAR is a key component of the Hyperic HQ agent and is used in other projects including <a id="aptureLink_WX9L4DHx0m" href="https://en.wikipedia.org/wiki/Hypertable">Hypertable</a>, <a id="aptureLink_Fy6elgHTOH" href="https://www.crunchbase.com/company/terracota">Terracotta</a>, <a id="aptureLink_RhcetOJ6YC" href="https://www.gridgain.com/">GridGain</a> and MySQL enterprise.
</td></tr>
<tr><td><br/></td></tr>



<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>Was SpringSource using continuous integration before Hudson? If so, what caused you guys to switch?</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>The SIGAR project actually started back in late 2002 and our initial CI system for the project was a good old-fashioned Perl script / ssh for-loop.  It was good enough to get by in the early years, but a proper replacement was long overdue.  We were (and still are) using <a id="aptureLink_koprNR3BrL" href="https://www.atlassian.com/software/bamboo/">Bamboo</a> to build and test Hyperic HQ.  We looked at using Bamboo for SIGAR, but at the time the "Remote Agent" feature was new to Bamboo and was not in the version we were running. Rather than disrupt HQ's CI along with taking on an additional licensing cost, we gave Hudson a shot and haven't looked back.
</td></tr>
<tr><td><br/></td></tr>




<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>Might be a bit of personal bias, but I think you guys made the right choice there! Checking out the <a href="https://hudson.hyperic.com">public Hudson server</a>, I see that SpringSource is building/testing products on AIX, the BSDs, various flavors of Linux, Solaris, Windows and Mac OS X, what kinds of languages/build systems are being built by Hudson? How varied are the environments that Hudson executes jobs in?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>
And HP-UX! The matrix of SIGAR's supported OS + kernel version + architecture + distribution is north of 100 combinations.  So, Hudson is covering a very heterogeneous collection of systems with most jobs tied to a specific node.  Our primary focus has been the C API and Java JNI bindings, using an Ant based build system and a JUnit test suite.  SIGAR also has language bindings for Perl, Ruby, Python, Erlang, PHP, C# and Lua.  So, Hudson is also driving each language's extension build system of choice, respectively: MakeMaker, Rake, distutils, emake, phpize, Nant and autotools.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>
What do you consider to be noteworthy about your Hudson implementation? Besides, clearly, that you're running Hudson slaves on just about every OS that will run Java :)
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>
<p>The majority of our x86/x64 nodes are virtualized on VMware ESX and VMware Server.  We also have a fine collection of PPC, PA-RISC and Sparc hardware in house, with IA-64 and s390x hosted elsewhere by third parties.  Some of these systems are too old to support Java 1.5 and/or Git.  As a simple work-around, the nodes share an NFS workspace where the slave node takes care of 'SCM' and 'Post-build Actions', but the 'Build' step in between is invoked via ssh.
</p><p>
The SIGAR distribution includes about two dozen native binaries that are compatible with most of the supported platform matrix.  There's a Hudson job for each Git branch that rolls these binaries into a release bundle. Another job flavor uses the Hudson URL SCM plugin to download and unit test the binary releases on the rest of the platform matrix.  This is key to testing binary compatibility.  Similar for the <a href="https://collectd.org">collectd</a> project, each Git branch has a job that runs automake, autoconf, etc. and 'make dist' into the collectd release flavor tarball.  So a push to git.verplant.org by octo in Germany triggers an update of the collectd release artifact, which in turn triggers the URL SCM jobs to download the tarball, unpack and build over here at our west coast locations.
</p><p>
We have four Hudson servers in different locations, three of which are managing most of the jobs behind firewalls.  Select jobs use the Build Publisher plugin to post the job and its artifacts to our <a href="https://hudson.hyperic.com">public Hudson server</a>. This makes it easy for us to provide platform specific bug fixes in binary form, share build logs with external projects and host a central repository of artifacts reachable by all of the URL SCM based jobs. Our public Hudson server also provides CI for the HQApi project and jobs to build HQ plugins, again making it easier to distribute patch fixes in binary form between releases.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>I've very impressed! I'm glad the fact that Java won't run on some of the platforms you want to support hasn't stopped you from testing anyways. Clearly you folks have written some addition tools behind the scenes, mind discussing them a bit?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>
Other than some Hudson plugin tweaks and additions, the Perl script I mentioned earlier was converted to generate the majority of our Hudson jobs and includes a simple templating system.  The same script generates jobs to build collectd and a few other projects.  We've outgrown this flavor of the script and have started working on integrating <a href="https://www.opscode.com/chef">Opscode Chef</a> to automate our Hudson configration along with the systems we build and test on. And of course, we're using Hyperic HQ to monitor our Hudson server instances, slaves and node machines.
</td></tr>
<tr><td><br/></td></tr>


<tr><td align="center">
<img src="/sites/default/files/butler_tiny.png" alt="Hudson"/><br/>
<strong>Hudson</strong>
</td><td>But of course, I'd say <a id="aptureLink_WWkmPVpHxI" href="https://en.wikipedia.org/wiki/Eating%20one%27s%20own%20dog%20food">dog-fooding</a> is an important part of any continuous testing set up. It appears that SpringSource has bought in pretty deeply to a Hudson-oriented workflow, given the amount of time and resources you all have invested in getting the massive farm set up that you have. That said, on a scale from 1-10, how important would you rate Hudson to your day-to-day workflow?
</td></tr>

<tr><td align="center" valign="top">
<img src="/sites/default/files/springsource.jpg" alt="Doug @ SpringSource"/><br/>
<strong>Doug</strong>
</td><td>I'd say at least an 8, although my daily workflow doesn't always directly involve Hudson.  Most of those points go to Hudson for automating what otherwise would be interrupting my workflow on a daily basis.
</td></tr>
<tr><td><br/></td></tr>

</table>

----


I'd like to thank Doug again for giving us a peek behind the curtains at SpringSource and how they're using Hudson. If you would like to discuss your organization or company's use of Hudson for Continuous Blog, you can contact me at `tyler` at `linux.com`



----
**Editor's note:** Doug was the primary author of <a id="aptureLink_qgVLRGgSjp" href="https://en.wikipedia.org/wiki/Mod%20perl">mod_perl</a> for many years until he was tricked into "helping out" with a new project.  This project turned into Hyperic HQ which shifted his focus to systems and application management for the past ~7 years and counting.  He occasionally rambles on Twitter as <a id="aptureLink_1GSwGzVfcP" href="https://twitter.com/dougmaceachern">@dougmaceachern</a>.
