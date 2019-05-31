---
:layout: post
:title: Workflow plugin is 1.0
:nodeid: 516
:created: 1417594188
:tags:
- development
- plugins
- pipeline
- workflow
:author: kohsuke
---
Jenkins started with a notion of jobs and builds at heart. One script is one job, and as you repeatedly execute jobs, it creates builds as records. As the use case of Jenkins gets more sophisticated, people started combining jobs to orchestrate ever more complex activities.

A number of plugins have been developed to enable all sorts of different ways to compose jobs, and many are used quite successfully in production. But this resulted in a certain degree of complexity for users to figure out how to assemble these plugins.

So we felt the need to develop a single unified solution that subsumes all these different ways to orchestrate activities that may span across multiple build slaves, code repositories, etc. Various inputs from users as well as other plugin developers played a key role.

The result of this is [the workflow plugin](https://github.com/jenkinsci/workflow-plugin), which is what a number of us, including Jesse Glick an myself, are focused on in the past few months.

The plugin approaches the problem by defining a DSL for you to describe an execution of a job. Various convenient primitives are available, such as executing shell scripts, checking out the source code, obtaining an executor or a build workspace, etc. All sorts of classic existing plugins contribute their functionalities into this DSL, such as recording test results, fingerprints, or calling into other existing jobs. This allows you to leverage higher-level functionalities and report comprehension capability into a workflow. Similarly, you can leverage the ability of Groovy, the host language of workflow DSL, to define control flows, abstractions, and reuse.

A key feature of a workflow execution is that it's suspendable. That is, while the workflow is running your script, you can shut down Jenkins or lose a connectivity to a slave. When it comes back, Jenkins will still remember what it was doing, and your workflow script resumes execution as if it was never interrupted. A technique known as the "[continuation-passing style](https://en.wikipedia.org/wiki/Continuation-passing_style)" execution plays a key role in achieving this.

I'm very happy to report that the workflow plugin is finally 1.0. This version runs on the latest 1.580-based LTS. and [we created a docker image for you to play with](https://github.com/jenkinsci/workflow-aggregator-plugin/tree/master/demo) too. There’s also [a JUC presentation](https://www.cloudbees.com/event/topic/workflow-jenkins-0) that explains this. We are working toward 1.0 release within this year, and in the meantime, the syntax is stable enough to allow you to start designing workflows today.

We've been hearing a lot of good feedbacks and enthusiasm for this new effort. Please let us know what you think.
