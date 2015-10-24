---
layout: post
title: 'JUC Speaker Blog Series: Damien Coraboeuf, JUC Europe'
nodeid: 564
created: 1433883272
tags:
- general
- jenkinsci
---
<div style="float:right; margin:1em">
<img src="https://jenkins-ci.org/sites/default/files/images/Jenkins_Butler_0.png" width=114 height=128>
</div>

<p><h3>Scaling and maintenance of thousands of Jenkins jobs</h3></p>

<p><h4>How to avoid creating of a jungle of jobs when dealing with thousands of them?</h4></p>

<p>In our organisation, we have one framework, which is used to develop products. Those products are themselves used to develop end user projects. Maintenance and support are needed at each level of delivery and we use branches for this. This creates hundreds of combinations.</p>

<p>Now, for each product or project version (or branch), we have a delivery pipeline. We start by compiling, testing, packaging, publishing. Then we deploy the application on the different supported platforms and go through different levels of validation, until we’re ready for delivery. Aside from a few details and configuration elements, most of the pipelines are identical from one branch to the other, from one project to the other.</p>

<p>So, one framework, some products, several projects, maintenance branches, complex pipelines… We end up having many many jobs to create, duplicate and maintain. Before even going into this direction, we saw this as a blocking issue - there was no way we could maintain manually thousands of jobs on a day to day basis.</p>

<p>The solution we were looking for should have the following characteristics:</p>

<ul>
<li>Self service - our goal being to delegate the job and branch administration in Jenkins to the projects, in order to reduce the support time
<li>Security - we didn’t want to open Jenkins to the projects at configuration level - not acceptable in our context
<li>Simplicity - the solution should be simple enough to be manageable by people not knowledgeable about the core technologies of Jenkins
<li>Extensibility - the solution must be flexible enough to allow extensions when needed
</ul>

<p>When we thought about using the Job DSL plug-in, delegating the creation of the pipeline to the project teams was OK from a self service point of view, but was not secure and definitely not simple for people not knowing Jenkins.</p>

<p>In the end, we opted for a solution where:</p>

<ul>The Jenkins team develops, maintains and versions several <i>pipeline libraries</i>
<li>A project team would edit a simple property file listing the characteristics of the current branch, like which type of platform is supported, which version of the <i>pipeline library</i> to use, etc.
<li>Upon commit of this shopping list, the complete branch pipeline is regenerated using the given version of the <i>pipeline library</i>
<li>The <i>pipeline library</i> code reads the “shopping list” property file and runs a Job DSL script to generate the branch pipeline according to those parameters
</ul>

<p>By default, the pipeline library generates a classic pipeline, suitable for most needs. It is also possible to define and use extensions, like having additional jobs in the pipelines.</p>

<p>In case of new features or defects, we develop or branch a new version of the pipeline library and projects or branches can use it by changing the version of their shopping list file.</p>

<p>A project gets injected into the system by having only a project seed being generated. From it, the authorised members can generate the branch seed and any branch pipeline at any time. Those seed jobs and the pipelines themselves can also be driven directly from the SCM using our plugin.</p>

<p>The project teams are now autonomous and can pilot their pipelines without requesting any support. They act in a secure and isolated way, and cannot compromise the shared environment. The “shopping list” file is simple and well documented. The system is not rigid and allows for extensions.</p>

<p>This platform has been developed initially for a very specific framework and a set of projects which depend on it, but has been extended since to be able to support other stacks. It is structured in two different parts:</p>

<ul>
<li>The seed platform itself - generation of branch structures in Jenkins and trigger end points for being piloted from the SCM
<li>The pipeline libraries, referenced from the shopping list files
</ul>

<p>We still allow some small tools and applications to define directly their pipeline by providing a Job DSL script.</p>

<p>Using the same principle, we can also pilot other tools in the ecosystem - like Artifactory or Ontrack.</p>

<p>I'll talk about this seed platform on June 24th, in the Jenkins User Conference in London.</p>

<div style="float:left; margin:1em">
<img src="http://jenkins-ci.org/sites/default/files/images/dcoraboeuf_0.preview.jpg" width=150 height=180>
</div>

<p>This post is by Damien Coraboeuf, Continuous Delivery Expert at Clear2Pay. If you have your ticket to <a href="http://www.cloudbees.com/jenkins/juc-2015/europe">JUC Europe</a>, you can attend his talk <a href="http://www.cloudbees.com/jenkins/juc-2015/abstracts/europe/02-03-1515-coraboeuf">"Scaling of Jenkins Pipeline Creation and Maintenance"</a> on Day 2.</p>

<p><i>Still need your ticket to JUC? If you register with a friend you can get 2 tickets for the price of 1! <a href="http://www.cloudbees.com/jenkins/juc-2015/">Register here for a JUC near you.</a></i></p>
<br><br><br><br><br>
<p><b>Thank you to our <a href="http://www.cloudbees.com/jenkins/juc-2015/sponsors">sponsors</a> for the 2015 Jenkins User Conference World Tour:</p></b>

<div style="float:left; margin:0em">
<img src="http://jenkins-ci.org/sites/default/files/images/sponsors-06032015-02_0.png" width=598 height=579>
</div>
