---
layout: post
title: 'JUC Speaker Blog Series: Nobuaki Ogawa, JUC Europe'
nodeid: 552
created: 1433186541
tags:
- general
- jenkinsci
---
<div style="float:right; margin:1em">
<img src="https://jenkins-ci.org/sites/default/files/images/Jenkins_Butler_0.png" width=114 height=128>
</div>

<p>On the 23rd and 24th June, I’ll attend <a href="http://www.cloudbees.com/jenkins/juc-2015/europe">Jenkins User Conference 2015 Europe</a> in London. And I’ll present a lightning talk about Continuous Delivery with Jenkins.</p>

<p>Here is short overview of what I’d like to talk about there.</p>

<p><h3>1. Continuous Build</p></h3>

<p>My starting point was to get to know JenkinsCI. Our developers used JenkinsCI to make the Continuous Build of our software.
So, our developing environment was quite Jenkins friendly from the beginning.</p>

<p><h3>2. Continuous Deploy</p></h3>

<p><h4><i>--- Virtual Machine ---</p></h4></i>

<p>We had to have an environment where we could deploy our new build. As we are big fans of Microsoft, we decided to use Azure as our environment to make Continuous Testing.</p>

<p>How do we control it? We use <a href="https://odehne.wordpress.com/2013/12/01/dealing-with-virtual-machines-in-windows-azure-using-powershell/">Powershell</a>, which can be executed with JenkinsCI.</p>

<p><h4><i>--- Product Deployment ---</p></h4></i>

<p>How did we achieve the Continuous Deploy? Actually, my boss, who is DirectSmile’s Yoda developed a very powerful tool called <a href="https://odehne.wordpress.com/2012/03/26/continuous-deployment-of-directsmile-products/">“DirectSmile Installation Service”</a> to enable this.</p>

<p>So we integrated this tool within JenkinsCI, and now Jenkins can deploy DirectSmile products on any target server with just one-button-click!</p>

<p><h3>3. Continuous Testing</p></h3>

<p>Of course, we use JenkinsCI to make the Continuous Testing.
How do we do that?
We use <a href="http://www.seleniumhq.org/">Selenium</a> to make and run tests. So we can cover most features and we can execute it at anytime.</p>

<p>We are doing it after every new version build, to obtain Continuous Delivery.</p>

<p><h3>4. Continuous Sharing</p></h3>

<p>I think it’s important to share all knowledge and experiences I have had with others, especially those whom have just started with Continuous Delivery.</p>

<p>Don’t worry, it is probably much easier than you think.</p>

<p>As a part of this practice, I’d like to share all my knowledge and experiences with how easy it is to achieve Continuous Delivery with Jenkins at JUC 2015.</p>

<p>I’m really exciting to meet and talk about this there! See you at JUC 2015 in London!</p>

<p><h3>About Me</p></h3>

<p>My name is Nobuaki Ogawa, from Japan, and I currently work in Berlin, Germany for the software company <a href="http://directsmile.com/">DirectSmile</a> as a DevOps QA Manager.</p>

<p>From the very first time I used JenkinsCI, it helped me a lot. Almost all the work I did last year was mainly with Continuous Delivery with Jenkins.</p>

<p>From Build to Deploy, Test, and even Maintenance and Monitoring, my Jenkins takes care of everything.</p>

<p>It was super easy to achieve Continuous Delivery in the DirectSmile world with the help of JenkinsCI.</p>

<div style="float:left; margin:1em">
<img src="http://jenkins-ci.org/sites/default/files/images/02-03-1530-ogawa_0.jpg" width=152 height=182>
</div>

<p>This post is by Nobuaki Ogawa, DevOps QA Manager at DirectSmile. If you have your ticket to <a href="http://www.cloudbees.com/jenkins/juc-2015/europe">JUC Europe</a>, you can attend his talk <a href="http://www.cloudbees.com/jenkins/juc-2015/abstracts/europe/02-03-1530-ogawa">"Jenkins Made Easy"</a> on Day 1.</p>

<p><i>Still need your ticket to JUC? If you register with a friend you can get 2 tickets for the price of 1! <a href="http://www.cloudbees.com/jenkins/juc-2015/">Register here for a JUC near you.</a></i></p>
<br><br><br><br><br>
<p><b>Thank you to our <a href="http://www.cloudbees.com/jenkins/juc-2015/sponsors">sponsors</a> for the 2015 Jenkins User Conference World Tour:</p></b>

<div style="float:left; margin:0em">
<img src="http://jenkins-ci.org/sites/default/files/images/sponsors-06032015-02_0.png" width=598 height=579>
</div>
