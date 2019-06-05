---
:layout: post
:title: 'Live Blog: John Smart demos advanced Hudson usage'
:nodeid: 259
:created: 1285090883
:tags:
- general
- javaone
:author: rtyler
---
**Editor's Note:** *This is a **very** rough set of notes from [John Ferguson Smart's](https://twitter.com/wakeleo) presentation at JavaOne 2010. Unlike [Kohsuke's presentation](https://jenkins.io/content/live-blog-kohsukes-presentation-javaone), John spent a lot of time in demos which made live-blogging a bit difficult.*

<center><a href="https://www.flickr.com/photos/hudsonlabs/5012383102/" title="John Smart (@wakeleo) talking about advanced Hudson use by hudson.labs, on Flickr"><img src="https://farm5.static.flickr.com/4129/5012383102_cf258075a6.jpg" width="500" height="375" alt="John Smart (@wakeleo) talking about advanced Hudson use" /></a></center>

John takes the stage at 9:30, this presentation is *totally* different from yesterday's presentation from Kohsuke

Taking Hudson a little further, beyond just scheduling a build job.


Who is **not** using Hudson, less than 10% raise hands.


Focusing on the more technical/nitty-gritty things with Hudson. Looking at:

 * CI Basics
 * Notification strategies
 * Quality metrics
 * Build promotions
 * Automated deployment
<!--break-->
Who knows what build promotions? Who uses build promotions? Very few in the audience use build promotions.


Who uses Hudson for automated deployment, a handful raise their hands. Plenty of Tomcat and JBOSS users automating deployment. John going to use Tomcat for the automated deployment demo in this presentation.


John mentions he's authoring the "Continuous Integration with Hudson" book, which will be available for download as it comes out.



Let's talk about Continuous Integration! Summing up what CI is in three words: **feedback, visibility** and **delivery**. CI is about *snappy feedback*. You want feedback in **minutes**.


Visibility should be associated with continuous integration, getting everybody in the product life cycle into the loop with continuous integration (product people, QA, developers, etc).



**What makes Hudson so great?** (according to John)

 * Easy to use
 * Plenty of plugins/the ecosystem around Hudson for extending/integrating Hudson
 * Reporting/coverage features
 * Distributed builds




First demo, the Hudson dashboard (starring the Nested View plugin). Starting with a basic dashboard filled with some unstable and stable builds. Cloudy builds thanks to Cobertura coverage grading.

Using the Nested View plugin to group views to make the dashboard more useflu for a **ton** of jobs.

Covering build radiators, not enough of the audience uses radiators. John advocates commandeering big monitors for radiators as part of your "notification strategy"



Covering the basic version control integration, John **highly** recommneds using a "Repository Browser". "The point is, you want one" John starts improvising with making some changes, pops over to Eclipse and refactors some code, commits and kicks off a build. Navigates to the source changes for the newly broken build in "Sventon", his repository browser of choice which was connected to the job

John shows the job using Maven integration and deploying artifacts to the Maven repository he's set up on his local machine.

Hudson will automatically keep track of jar files/war files, so enable the "Discard Old Builds" checkbox to prevent Hudson from eating all kinds of disk space. Useful to only discard the artifacts for the last X builds instead of the test results/code coverage.


Desktop build notifiers are quite useful, email can tend to get clutter/lost in the mess with everything else coming into your inbox.


#### Test results integration

Going into the test results dashboard per-build and the test-result and build time trends for a specific job.

Why is the build time trend useful? If the build suddenly takes a *huge* amount of time to run, you've likely got performance issues that need fixing.


#### Publishing HTML reports

Starring the HTML Publisher plugin! Using the plugin to publish HTML reports generated from easyb for publishing acceptance test results for more wide-spread consumption.

Bouncing from HTML reports to integrating with Sonar for code quality metrics



#### Build Promotion

Starring the Promoted Builds plugin! Covering some similar concepts to Kohsuke's talk yesterday but literally going into the Hudson configuration and setting it up.



Time is running out, John's flipping back and forth between the M2 release plugin and his automatic deployment to his local Tomcat environment.



#### Q&A

"Can Hudson be used for other environments". Yes! Supports a number of build plugins, MSBuild, NAnt, CMake, in addition to the freestyle build. "Maven 3 support" Sonatype is apparently working on an integrated version of Hudson with Maven 3, Hudson core planning support "eventually."
