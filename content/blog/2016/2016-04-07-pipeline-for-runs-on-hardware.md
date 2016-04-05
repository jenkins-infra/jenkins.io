---
layout: post
title: Automating test runs on hardware with Jenkins and Pipeline-as-Code
tags:
- jenkins
- pipeline
- embedded
author: oleg_nenashev
---

## Introduction

In automotive projects it's frequently required to run tests on specific hardware peripherals: development boards, prototypes, etc.
It may be required for both software and hardware areas, and especially for products involving both worlds.
CI and CD methodologies require continuous integration and system testing, and Jenkins comes to help here.

Jenkins is an automation framework, which can be adjusted to reliably work with hardware attached to its nodes.
The classic approaches based on Free-style and matrix projects are well described in the [Embedded Solutions page](http://jenkins.io/solutions/embedded/) on the Jenkins website. 
Here we will concentrate on the added-value features being provided by Pipeline.

## Area challenges

Below you can find a common connection scheme of peripherals:

![Connecting the external board](./images/connectBoard.png)

This scheme is commonly affected by the following issues:

* Nodes with peripherals are being shared across several projects. 
Jenkins must insure the correctness of access (e.g. by throttling the access). 
 * In a single Freestyle project the build utilizes the node for a long period. If you synthesize the item before the run, much of the peripheral utilization file may be wasted.
 * The issue can be solved by Throttle Concurrent Builds or Shared Resources, but generally such solutions require creation of build chains
 * These build chains can be created via Parameterized Trigger and Copy Artifacts, but it makes the job management and build history investigation very complex
* Test parallelization on multiple nodes requires using of multiple projects or Matrix configurations, so it causes job chaining again.
* Hardware infrastructure is always flaky. If the infrastructure fails due to any reason, it's hard to diagnose the issue and re-run the project in the case of the infra failure.
* Tests on hardware peripherals may take much time. If an infrastructure fails, we may have to restart the run from scratch. So the builds should be robust against infra issues including network failures and Jenkins master restarts.

Usage of Pipeline can address the use-cases above.
In this blogpost we will address several cases.

## Pipeline-as-Code for test runs on hardware

Pipeline-as-Code is an emerging technology for representing job configurations as code.
In Jenkins there are two dominant implementations - Pipeline and JobDSL plugins.
JobDSL Plugin internally generates common freestyle jobs according to the script, so it's functionality is similar to the description above.
In this post I will concentrate on the Pipeline plugin.

Below you can find an example of Pipeline scripts, which runs tests on FPGA board. The id of this board comes from build parameters (_fpgaId_). In this script we also presume that all nodes have pre-installed tools (Xilinx ISE in this case).

```groovy
// Run on node having my_fpga label 
node("linux && ml509") {
  git url:"http://github.com/oleg-nenashev/pipeline_hw_samples";
  sh "make all";
}
```

But such scenario could be also implemented in a Free-style project.
What would we get from Pipeline plugin?

## Getting added-value from Pipeline-as-code

Pipeline provides much added-value features for hardware-based tests. 
I would like to highlight the following advantages:
* Tolerance against restarts of Jenkins master
* Robustness against network disconnects. _sh_ steps effectively implement [Durable Tasks](http://TODO), so Jenkins can safely continue the execution flow once the node reconnects
* It's possible to run tasks on multiple nodes w/o creating complex flows based on job triggers and copy artifact steps, etc. It can be achieved via combination of _parallel()_ and _node()_ stages.
* Ability to store the shared logic in standalone Pipeline libraries
* ...

First two advantages allow to improve the robustness of Jenkins nodes against infrastructure failures. 
It is critical for 

## Utilizing pipeline features

The sample Pipeline script above is very simple. 
We would like to get some added value from Jenkins.

### General improvements

Let's enhance the script by using several features being provided by pipeline in order to get visualization of stages, report publishing and build notifications.

We also want to minimize the time being spent on the node with the attached FPGA farm. 
So we will split the bitfile generation and further runs to two different runs.

You can find the resulting Pipeline script below:

```groovy
// Synthesize on any node
node("linux") {
  stage "Prepare environment"; 
  git url:"http://github.com/oleg-nenashev/pipeline_hw_samples";
  // Some magic for getting the commit id
  sh 'git rev-parse HEAD > GIT_COMMIT'    
  imageId = "myprj-${fpgaId}-" + readFile('GIT_COMMIT').take(6)
  
  stage "Synthesize project"
  sh "make FPGA_TYPE=$fpgaId synthesize_for_fpga"
  // We archive the bitfile before running the test, so we won't loose it if something happens with the build node
  archive "target/image_${fpgaId}.bit"
}

/* Run on node having my_fpga label. In this example it indicates that the Jenkins node contains the attacked FPGA of such type */
node (linux && $fpgaId) {  
  stage "Blast bitfile"
  unarchive "target/image_${fpgaId}.bit"
  sh "make impact target/image_${fpgaId}.bit"
  
  // We run automatic tests and report results from the generated JUnit report
  stage "Auto Tests"
  sh "make tests"
  sh "perl scripts/convertToJunit.pl --from=target/test-results/* --to=target/report_${fpgaId}.xml --classPrefix=\"myprj-${fpgaId}.\"";
  step([$class:"JUnitResultArchiver", testResults:"target/report_${fpgaId}.xml"])
  
  // Now we ask engineers to perform manual tests
  stage "Manual Tests"
  input "Autotests passed on ${env.NODE_NAME}. Run manual tests on and click 'Proceed' if everything is fine"
  
  stage "Finalization"
  sh "make flush_fpga"
  //TODO
  hipchat "${imageId} testing has been completed"
}
```

As you may see, pipeline mostly consists of various calls of CLI tools via the _sh()_ command. Particular steps have been intentionally expanded in order to represent the pipeline.

It is possible to continue expanding the pipeline in such way.
[Pipeline Examples](https://github.com/jenkinsci/pipeline-examples) contain examples for common cases: build parallelization, code sharing between pipelines, error handling, etc.

## Lessons learned

During the last year I've tried using Pipeline for Hardware test automation several times. 
The ecosystem evolves rapidly, but there are still several missing integrations.

I would like to mention the following ones:

* Native support of shared resource management across pipelines. It can be done by the incoming support in the [Lockable Resources plugin](https://wiki.jenkins-ci.org/display/JENKINS/Lockable+Resources+Plugin) ([JENKINS-30269](https://issues.jenkins-ci.org/browse/JENKINS-30269)) 
* Integration with [Throttle Concurrent Builds plugin](https://wiki.jenkins-ci.org/display/JENKINS/Throttle+Concurrent+Builds+Plugin), which is an effective engine for quoting the license utilization in automation infrastructures
* Integration with [Custom Tools Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Custom+Tools+Plugin), which is useful for integration of IDEs, especially in the case of multiple tool versions.
* Pipeline package manager with dependency management, which would allow developing Pipeline libraries and sharing them between teams. [Pipeline Global Library](https://github.com/jenkinsci/workflow-plugin/blob/master/cps-global-lib/README.md) and [Pipeline Remote Loader](https://github.com/jenkinsci/workflow-remote-loader-plugin) can be used as a workaround
* Pipeline debugger. HW test runs are very slow, so it is very hard to troubleshoot and fix issues in the Pipeline code. There are several features  

## Summary

Jenkins is a powerful automation engine, which can be used in many areas.
It beats other Continuous Integration tools thanks to its flexibility and general-purpose plugins.
Even though Jenkins has no dedicated plugins for test runs on hardware, it provides enough "building blocks" for various use-cases.
That's why Jenkins is so popular in the hardware and embedded areas.

Pipeline plugin is an emerging technology, which should greatly simplify the implementation of complex flows.
Currently it lacks integrations with several Jenkins plugins, but hopefully this issue will be solved soon.

If you develop new automation flows, consider Pipeline as one of possible approaches.

## What's next?

Jenkins automation server dominates in the HW/embedded area, but unfortunately there is not so much experience sharing for these use-cases. 

I am going to talk about running tests on hardware at the [incoming Automotive event](https://www.eventbrite.com/e/accelerating-automotive-innovation-with-continuous-integration-delivery-tickets-20809772590) in Stuttgart on April 26th.
This event is being held by [CloudBees](https://www.cloudbees.com/), but there will be multiple talks addressing Jenkins open-source as well.

If you want to share your experience about Jenkins usage in Hardware/Embedded areas, consider submitting a talk for the [Jenkins World conference](https://jenkins-cfp.herokuapp.com/events/jenkins-world-2016) or join/organize a [Jenkins Area Meetup](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+Area+Meetup). 
There is also [Jenkins Online Meetup](http://www.meetup.com/Jenkins-online-meetup/).

## Links

Related articles and events:

* [Embedded Solutions page on the Jenkins website](http://jenkins.io/solutions/embedded/)
* [Jenkins-Based CI for Heterogeneous Hardware/Software Projects](https://www.cloudbees.com/jenkins/juc-2015/presentations/JUC-2015-Europe-Jenkins-Based-CI-for-Nenashev.pdf)
* [Accelerating Automotive Innovation with Continuous Integration & Delivery](https://www.eventbrite.com/e/accelerating-automotive-innovation-with-continuous-integration-delivery-tickets-20809772590)

Pipeline:

* [Pipeline Tutorial](https://github.com/jenkinsci/workflow-plugin/blob/master/TUTORIAL.md)
* [Jenkins 2.0 and Pipeline-as-code overview](https://speakerdeck.com/onenashev/spb-jenkins-meetup-number-1-jenkins-2-dot-0-i-pipeline-as-code-eng)
* [Pipeline Examples](https://github.com/jenkinsci/pipeline-examples) 
