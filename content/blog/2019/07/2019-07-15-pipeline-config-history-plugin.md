---
layout: post
title: "Introducing the Pipeline Config History Plugin"
tags:
- pipeline
- plugins
---

[Pipelines](https://jenkins.io/doc/book/pipeline/) are the efficient and modern way how to create jobs in Jenkins. To recognize changes of pipelines in a fast and easy way, we developed the plugin [Pipeline-Config-History](https://plugins.jenkins.io/pipeline-config-history). This plugin detects changes of pipelines and provides the user an option to view changes between two builds (diffs) of pipeline configurations visibly and traceably.


## How everything started

It all started 10 years ago -- with classical job types (e.g. Freestyle, Maven, etc.). Every once in a while users contacted us because their jobs failed to build overnight. What was the reason for this failing jobs? Were there any changes on the job configuration maybe? The users' typical answer was: "We didn't change anything!", but is that really true? We thought about this and decided to develop a plugin that should help us to solve this problem. This was the idea and the beginning of [JobConfigHistory](https://plugins.jenkins.io/jobConfigHistory)..

Now it was possible to view changes of job configurations (like other branches, JDK versions, etc.) and more often the reason for breaking builds were changes of job configurations.

![Screenshot von JobConfigHistory](https://wiki.jenkins.io/download/attachments/42469550/Diff_2.6.png)

Over the years the plugin got developed and is still under development. New functions were added, that not only view job configurations, but also changes of global and agent configurations. It is also possible to recover old configuration versions. Today the plugin has more than 30,000 installations. For many years JobConfigHistory relieves our daily work -- with more than 3,000 Jenkins jobs!
Then there were a new type of job: **Pipelines**.


## Pipelines - something new was needed

Pipeline jobs differ from classical job types funtamentally. While classic job types get configured via the Jenkins GUI, Pipeline jobs get configured as code. Every pipeline job indeed gets created via the Jenkins GUI, however that is not necessarily where the pipeline configuration is located. There are different ways where pipelines can get configured:
* Directly in the Jenkins job as script. The code gets inserted directly in the job configuration page.
* As Jenkinsfile in the source code management system (SCM): The pipeline configuration is defined in a text file (Jenkinsfile) in the SCM. In the job itself only the path to the repository of the Jenkinsfile is configured. During the build the Jenkinsfile gets checked out from the SCM and processed.
* As shared library: A part of the pipeline configuration gets moved to own files, that can be used by several jobs. These files are also saved in the SCM. Even so a Jenkinsfile is still needed (or a pipeline script in the job).

With every save operation of the job configuration, JobConfigHistory creates a copy of the actual job configuration if something has changed. For pipeline jobs that only works if the pipeline configuration is inserted in the job configuration page as script. Jenkinsfiles or shared libraries cannot get detected by JobConfigHistory. You have to go to the SCM to view changes of the Jenkinsfiles or shared libraries. It is complex and time intensive to find a correlation between the time of a build and a change to the Jenkinsfile or shared library.

This new problem cannot get solved by JobConfigHistory and a new solution were needed to get found, that also detects these changes and provides a way to view these changes within the Jenkins GUI. So we developed Pipepline-Config-History.

During every pipeline run the Jenkinsfile and used shared libraries get saved in the `builds` directory of the job. The function of Pipeline-Config-History is to check after every pipeline run, if there were changes of the pipeline files between the last and the previous run and if so, it saves these files as history events. Therefore when a pipeline job ceases to build successfully, you can check if something has changed on any used pipeline file. You can also see the build where changes occurred.

![Screenshot von Pipeline-Config-History](https://wiki.jenkins.io/download/attachments/175210534/image2019-5-15_13-44-54.png)

Because a pipeline configuration can consist of several files where changes could have occured, only those files in which something has changed between two builds get shown at the diff. That makes the whole thing more compact and effective:

![Screenshot von PCH](https://wiki.jenkins.io/download/attachments/175210534/image2019-5-15_14-5-13.png)

But sometimes you may want to show not just the differences between pipeline files, also which pipeline files are in use and what the content of these files are. So it's possible to view all files and its contents. If required you can download them as well:

![Screenshot von PCH](https://wiki.jenkins.io/download/attachments/175210534/image2019-5-15_14-11-7.png)


## Conclusion

We use Pipeline-Config-History successfully in production and it helped us from the first day on solving problems that occurred because of changes of pipeline configurations. Pipeline-Config-History won't replace JobConfigHistory. Both plugins have different use cases. Many times small changes on job or pipeline configurations also have big impacts. Because of the correlation in time between changes of job or pipeline configurations and different build behavior, it is now possible to reduce the time effort to analyze the build failures substentially. With the usage of JobConfigHistory and Pipeline-Config-History we are able to help our users in cunsulting and bug solving issues/problem situations much faster, what makes these plugins essential for our daily work.


## Authors:
* Jochen A. Fürbacher, 1&1 Telecommunication
* Stefan Brausch, 1&1 Telecommunication
* Robin Schulz, 1&1 Telecommunication
