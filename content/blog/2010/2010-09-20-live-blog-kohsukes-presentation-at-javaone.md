---
:layout: post
:title: 'Live Blog: Kohsuke''s Presentation at JavaOne'
:nodeid: 255
:created: 1285005819
:tags:
- general
- javaone
:author: rtyler
---
**Editor's note:** *This is a **very** rough set of notes from [Kohsuke Kawaguchi's](https://twitter.com/kohsukekawa) presentation at JavaOne 2010.*


<a href="https://www.flickr.com/photos/hudsonlabs/5008629375/" title="Kohsuke talks to a packed room at #JavaOne by hudson.labs, on Flickr"><img src="https://farm5.static.flickr.com/4083/5008629375_6f603b6093_m.jpg" width="180" height="240" alt="Kohsuke talks to a packed room at #JavaOne" align="right"/></a>

Kohsuke takes the stage, asks "who uses's Hudson" the majority of
audience raises their hands

Discussing the great ecosystem using Hudson across the wide-variety of platforms/languages.
330+ community written plugins. Last year at JavaOne we had 230+ plugins


Eclipse Community Survey, Hudson adoption from 9.1% in 2009 to 21.8%

Discussing Hudson adoption, going over Hudson job postings on indeed.com going up compared to a stagnant Cruise Control.


Kohsuke introduces himself and InfraDNA, started Hudson in 2004/2005. 



First steps to CI, 10,000 foot overview of SCM monitoring/build/testing. Delving into using Hudson
for automating **everything** to get "more out of your Hudson deployment.



### "Interconnecting Jobs aka Workflows"

Hudson allows for hosting many projects on one Hudson deployment, meaning you need a smaller number of administrators for a larger number of jobs compared to Cruise Control.

Building Block #1: Triggering. Using "upstream" and "downstream" jobs ot interconnect jobs to form a workflow in Hudosn. Triggering is asynchronoys in Hudson, useful for separating builds and multiple test jobs. Splitting the build and test jobs so you build quickly test many tests in parallel.

Avoid recompiling compilation/builds in the "downstream" test runs. "Copy Artifact" plugin very useful for passing built executables to test jobs.

Upstream/downstream separation also highly useful for separating build and deployment into a continuous workflow.

Building Block #2: Join plugin. Fan downstream jobs out and then bring everything back together for final
steps.

Shows Join plugin configuration screen because "perhaps the configuration is a little unintuitive".


Building block #3: Fingerprints. Using MD5 checksums from artifacts to learn more about those artifacts in your
Hudson, tying together artifacts from different jobs/builds. Letting Hudson recording these fingerprints of those artifacts in your lifecycle allows Hudson to help you find out where/when those executables came from.

Fingerprinting mechanism good for tracking dependencies from third parties, Hudson uses 3rd party fingerprints to compute additional information. Also useful for aggregating reports.

Going a bit further using the "build promotion plugin" to weed out which builds are "better than others." Taking fingerprints from a build job all the way through the life cycle and passing that fingerprint around test/smoke test jobs, if that passes, build passes on to more rigorous testing, only if it's passed base-level testing. Basic model of promotion maps to a "confidence level", 1st level passes compilation, 2nd level passes smoke test, 3rd level passes expensive/time-consuming tests.

One of the reasons to use promotion in your lifecycle to ensure that artifacts meet a minimum "confidence level" so you're not expending resources running the longer tests )think about a promotion hierarchy)


**Demo time!**

Kohsuke demoing build promotion live with fingerprinting of sample jar files. Creating a "component-X" build and a "test-X" build. test-X job using the "Copy Artifact" plugin to grab artifacts from the component-X build.

Defining the promotion criteria in "component-X", "test-X" promoted, indicates that certain builds promoted a build.

**End demo time!**


### Maven Integration

Maven integration highlights. Going over POM comprehension and simplified configuration due to more information
getting inferred from the POMs. Building dependency chains with Maven integration.

"That's the basics, let's talk about advanced integration with Maven"

Parallel-module builds! Letting Hudson builds modules with a single checkbox, meaning wherever possible Hudson will try to build your modules in parallel when possible.

Incremental builds! Only building changed modules in a build run to be more efficient, preventing the need to rebuild the whole project from scratch every time. Hudson's SCM integration to determine what the mapping between files changed and modules needing to be built.

Private Maven repositories! Avoiding artifacts being overwritten by others, telling Hudson to create a Maven repository **per-project** (at the expense of more bandwidth/disk space needed), helps segregate builds to avoid them stomping on each other.

After-the-fact deployment, avoiding deploying modules unless the whole build is successful (all modules properly built). Instead of using `mvn deploy`, you tell Hudson to deploy to your Maven repository with a single checkbox.


### Matrix Project

No longer alpha! Production-ready!

Often used to build/test across slight variations of build environments such as different platforms for a C++ project. Conceptually it's like running your build in a for loop.


Hudson supports a number of different axes, most popular of which being a "slave axis" which allows you to use different labels or specific slaves for the build. Hudson also supports arbirtrary text fields as axes to be passed along to the build steps as environment variables.


Touching on "filtering" in the matrix project support to remove parts of an axis that you do not need. I.e if you have a "platform" and a "browser" axes for web testing, you can exclude the "iexplore" value of the "browser" axis when the "platform" axis is "mac".

**Demo time!**

Defining two axes, "slave" axis and the "JDK" axis to build against different JDK versions on linux, solaris and windows. Excluding "touchstone builds" to avoid rebuilding a large number of matrix builds unless a limited subset of the combinations successfully build. Used to avoid spending a lot of time spinning cycles on very obvious errors that the first few builds "recognize" immediately.

**End demo time**


### Doing Selenium testing on Hudson

Use "Selenium Grid plugin" to install Selenium binaries on all slaves and prepares them all to talk to each other. Useful for "overloading" an existing Hudson cluster as a Selenium cluster.

Using labels in Hudson to better determine which node has which browser.

Selenium integration is **very** powerful when combined with the join plugin and the matrix configuration support in Hudson for web testing across a large number of platforms and browsers.


The Hudson project has invested heavily in getting great cluster support which helps tremendously with Selenium which has invested as heavily in clustering.

How to you deal with Selenium needing a GUI while Hudson slaves are largely headless. Use the Xvnc plugin! On Windows things are bit trickier, easier to let Hudson slave/service "interact with desktop" such that it can access dialogs/etc. Failing everything else, configuring Windows for auto-login and then have JNLP slaves autostart at login will work for allowing the slave to use the GUI and network resources.



The rest of the session was dedicated to some good Q&A. Great session by Hudson's founder.
