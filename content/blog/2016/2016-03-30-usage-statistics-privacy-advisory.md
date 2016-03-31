---
layout: post
title: Important notice regarding usage statistics
tags:
- general
author: daniel-beck
---

A bug was introduced in Jenkins versions 1.645 and 1.642.2 which caused Jenkins
to send [anonymous usage statistics](https://wiki.jenkins-ci.org/display/JENKINS/Usage+Statistics) data,
even if the administrator opted-out of reporting usage data in the Jenkins web
UI.

If you are running one of the affected versions, the best/easiest solution is
to upgrade. The bug does not affect Jenkins 1.653 or newer, or Jenkins LTS
1.642.4 or newer.

If you cannot upgrade, it is possible to immediately disable submission of
usage statistics by running the following script in "Manage Jenkins » Script Console":

    hudson.model.UsageStatistics.DISABLED = true

This will immediately disable usage data submission until you restart Jenkins.
To make this permanent, change your Jenkins startup script so it passes a
system property to the java process:

    java -Dhudson.model.UsageStatistics.disabled=true -jar …/jenkins.war

For information how to do this when using one of the installers/packages, [see
the installer/package documentation
here](https://wiki.jenkins-ci.org/display/JENKINS/Native+Packages)

To verify that usage stats submission is disabled, run the following script in
"Manage Jenkins » Script Console" and confirm the result is true:

    println hudson.model.UsageStatistics.DISABLED


We have much more information about the issue and our usage statistics process
[in our wiki](https://wiki.jenkins-ci.org/display/JENKINS/Usage+Statistics+Privacy+Advisory+2016-03-30).

