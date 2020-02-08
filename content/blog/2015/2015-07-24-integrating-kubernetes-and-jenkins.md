---
:layout: post
:title: Integrating Kubernetes and Jenkins
:nodeid: 585
:created: 1437747464
:tags:
- general
- plugins
- video
:author: daniel-beck
---
[Kubernetes](https://kubernetes.io/) is an open-source project by Google that provides a platform for managing Docker containers as a cluster. In their own words:

> Kubernetes is an open source orchestration system for Docker containers. It handles scheduling onto nodes in a compute cluster and actively manages workloads to ensure that their state matches the users declared intentions. Using the concepts of "labels" and "pods", it groups the containers which make up an application into logical units for easy management and discovery.

Kubernetes-related services by Google are the [Google Container Engine](https://cloud.google.com/container-engine/), a Kubernetes-powered platform for hosting and managing Docker containers, and the [Google Container Registry](https://cloud.google.com/tools/container-registry/#overview), a private Docker image registry.

Several new Jenkins plugins allow you to make use of Kubernetes and these services:

* The [Google Cloud Registry Auth Plugin](https://wiki.jenkins.io/display/JENKINS/Google+Container+Registry+Auth+Plugin) allows users to authenticate with the Google Cloud Registry so they can push/pull images. This allows you to use the Google Cloud Registry with existing Docker-related plugins, like [Docker build step plugin](https://wiki.jenkins.io/display/JENKINS/Docker+build+step+plugin) or [CloudBees Docker Custom Build Environment Plugin](https://wiki.jenkins.io/display/JENKINS/CloudBees+Docker+Custom+Build+Environment+Plugin).
* The [Kubernetes Plugin](https://wiki.jenkins.io/display/JENKINS/Kubernetes+Plugin) implements a cloud provider for Jenkins, and can create slaves based on Docker images on-demand on your Kubernetes cluster or the Google Cloud Platform.

[Watch Kohsuke demoing Jenkins/Kubernetes integration at OSCON earlier this week.](https://www.youtube.com/watch?v=PFCSSiT-UUQ&index=21&list=PL69nYSiGNLP0Ljwa9J98xUd6UlM604Y-l)

For a more in-depth look at how you can use Kubernetes with Jenkins, check out these posts on the CloudBees blog by Tracy Kennedy:

* [Orchestrating deployments with Jenkins Workflow and Kubernetes](https://blog.cloudbees.com/2015/07/orchestrating-deployments-with-jenkins.html)
* [On-demand Jenkins slaves with Kubernetes and the Google Container Engine](https://blog.cloudbees.com/2015/07/on-demand-jenkins-slaves-with.html)
* [Clustering Jenkins with Kubernetes in the Google Container Engine](https://blog.cloudbees.com/2015/07/clustering-jenkins-with-kubernetes-in.html)
