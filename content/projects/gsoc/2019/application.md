---
:layout: simplepage
:title: "Jenkins GSoC application draft, 2019"
:tags:
- gsoc
- gsoc2019
---

<!-- This file uses Markdown intentionally.
     Google's GSoC site uses Markdown as an engine, using Markdown here allows copy-pasting
 -->

The data below represents the 2019 GSoC application draft.
Please feel free to contribute to it by proposing pull requests against the page.

### Organization Profile

* Tagline (up to 80 symbols): Open-source automation server for building great things at any scale
* Technology tags (max 5): 
  * java
  * groovy
  * javascript
  * docker
  * kubernetes
* Topic Tags (max 5)
  * continuous integration
  * continuous delivery
  * developer tools
  * devops
  * automation
* Ideas list: https://jenkins.io/projects/gsoc/2019/project-ideas/ 
* Primary open-source license: MIT License
* Category: Programming Languages and Development tools
* Logo: https://wiki.jenkins.io/download/attachments/2916393/logo-title.png

#### Short description

Jenkins is an open source automation server. 
Built primarily in Java, it provides hundreds of plugins to support building, testing, deploying and automating virtually any project.

#### Long description (Markdown)

[Jenkins](https://jenkins.io/), originally founded in 2006 as "Hudson", is one of the leading automation servers. 
Jenkins' motto is "Build great things at any scale".
Using an extensible, plugin-based architecture developers have created hundreds of plugins to adapt Jenkins to a multitude of build, test, and deployment automation workloads. 
Jenkins core is open-source ([MIT License](https://www.opensource.org/licenses/mit-license.php))

The project has about 400 active contributors working on Jenkins core, plugins, website, project infrastructure, localization activities, etc. 
In total we have more than 2000 components including plugins, libraries, and various utilities. 
The main languages in the project are Java, Groovy and JavaScript, 
but we also have components written in other languages (Go, C/C++, C#, etc.).
Jenkins project also includes multiple 
[sub-projects](https://jenkins.io/projects/) (including [Jenkins X](https://jenkins-x.io/), 
[Configuration-as-Code](https://jenkins.io/projects/jcasc/) 
and [Remoting](https://jenkins.io/projects/remoting/)) and 
[special interest groups](https://jenkins.io/sigs/).
These projects and SIGs participate in GSoC as a part of the Jenkins project.

This year we invite students to join the Jenkins community and to work together on Jenkins plugins in order to improve Jenkins user experience and reliability.

#### Proposal process:

In order to apply to the organization, please follow the [guidelines posted on our website](https://jenkins.io/projects/gsoc/students/#student-application-process). 

Before submitting please go through the page (including the expectations section) and through the [Student guide](https://google.github.io/gsocguides/student/). 
Participating in Google Summer of Code is a serious commitment requiring an almost full-time dedication over several months. 
If it may overlap with your study and other commitments, we recommend to think twice before applying.

If you have any questions about the application process, 
please feel free to contact us via the mailing list or the chat.

#### Proposal tags (max - 10)

* user experience
* plugins
* performance
* developer tools
* electronic design automation
* web interfaces
* REST API
* cloud technologies
* containers
* configuration-as-code

#### Contents

* Chat page URL: https://app.gitter.im/#/room/#jenkinsci_gsoc-sig:gitter.im

### Application

#### Why does your org want to participate in Google Summer of Code?

In our community we are interested in more contributors in both Jenkins core and more than 1,000 of existing plugins. 
We consider Google Summer of Code as an opportunity to find new contributors and students interested in software development automation (continuous integration and continuous delivery). 
For us it is also a great opportunity to get existing contributors more involved into the community work. 
We have previously participated in GSoC 2016/2018 and got much experience from it, especially regarding the student selection process. 
We hope this will help us to improve student/mentor experience and overall results this year.

#### How many potential mentors have agreed to participate?

20+

#### How will you keep mentors engaged with their students?

* Each student project will have at least 2+ mentors AND an org admin advisor assigned to the project.
* Mentors are expected to be accomplished Jenkins contributors, who are passionate about the community/mentorship work.
* Mentors bring their own project, and they are expected to have a high interest in it
* Mentors will be directly involved into student selection and interview processes so they will establish connection with successful students early
* We do not require mentors to be experts in the code base, because we expect students to work with other community members.
* Starting from Dec 2018 we conduct [weekly meetings](https://jenkins.io//projects/gsoc/#office-hours) between mentors and org admins to sync-up on progress and any issues:
* As org admins we will be monitoring mentor/student interaction starting from the application phase. If something goes wrong, as org admins we will jump in and/or find additional mentors


<!-- DOES NOT FIT the form size
* There will be a private communication channel between org admins and mentors. 
-->

#### How will you help your students stay on schedule to complete their projects?

* During the Community Bonding phase mentors will share their expertise in order to define realistic project plans, design document, and effort estimations.
* The student project milestones will be discussed and confirmed between mentors and students. 
  Milestones will be aligned with student evaluations and will have clear expectations set up.
* Mentors will set up regular meetings with students (at least twice per week) in order to sync-up on projects. 
  We will also recommend having retrospectives with students after evaluations.
* Mentors should be available for questions. 
They should also provide a periodic feedback on the progress of the project and on the performance of particular students (1x1).
* We will set up weekly public office-hours with students (or two meetings if time-zones require it) and private ones between mentors and org admins to sync-up
* We will be requiring a daily push to branches so that the students always show the progress and keep changes atomic.

<!-- DOES NOT FIT form size 
* During the coding period, mentors will participate in the code reviews of their student and report to org admins if the project stalls.
-->

#### How will you get your students involved in your community during GSoC? 
         
* Students will cooperate with Jenkins community during the project. 
  Org Admins will provide an introductory training (community overview, code-of-conduct, etc.), 
  then mentors will help students to establish contacts with experts from the community
* We will ensure that students are around in public chats and other communication channels during the “working days”
* Projects will handled under an umbrella of
  [SIGs](https://jenkins.io/sigs) or [sub-projects](https://jenkins.io/projects)
  so that there is a number of non-mentor stakeholders and early adopters
* Students will be involved into all standard processes in our community (including pull requests, code reviews, IRC/Gitter discussions, test automation for their projects, documentation development, etc.).
* Students will be participating in sub-project/SIG meetings and presenting their work there on a regular basis
* Students will be encouraged to give updates to the wider community in the Jenkins blog

#### How will you keep students involved with your community after GSoC?

* There will be a [DevOps World - Jenkins World conference](https://www.cloudbees.com/jenkinsworld/home) in USA in August 2019 and then in Europe in Dec 2019. 
  We plan sponsoring successful students to go to this or other Jenkins-focused conference & contributor summit.
  The projects will be also presented at the [Jenkins Online Meetup](https://www.meetup.com/Jenkins-online-meetup/).
* Students will be developing their own modules for Jenkins and effectively they will retain ownership of these modules after GSoC (they can opt-out, of course). 
  Public presentations will attract attention, and the students will be periodically contacted by users.
* Students will be also advised to present their projects at local Jenkins Area Meetups (https://jenkins.io/projects/jam)
* Each project will have a strict Definition Of Done: public availability, Q&A chats, [blog posts on the project website](https://jenkins.io/blog/). 
  The students will be visible in the community even after GSoC

#### Has your org been accepted as a mentoring org in Google Summer of Code before?
Yes, in 2016 and 2018

2018: 2/3 (+1 cancelled project during community bonding)
2016: 1/5 (3 students have been failed due to major undisclosed time commitments, which impacted the project quality at the first coding phase)

#### If your org has applied for GSoC before but not been accepted, select the years
2009, 2017

#### If you are a new organization to GSoC, is there a Google employee or previously participating organization who will vouch for you? If so, please enter their name, contact email, and relationship to your organization. (optional)

EMPTY

#### What year was your project started?

2006

#### Where does your source code live

https://github.com/jenkinsci/ ,
https://github.com/jenkins-x/ ,
https://github.com/jenkins-infra/

#### Are you part of a foundation/umbrella organization?
Yes, Software in the Public Interest, Inc. (https://spi-inc.org) a 501 (c) (3) non-profit organization

#### Anything else we should know (optional)?

There is a probability that Jenkins project migrates from SPI to Linux Foundation this year
[ongoing discussion](https://groups.google.com/d/msg/jenkinsci-dev/1w57jl3K4S4/OFDYSEfXEwAJ). 
GSoC org admins closely monitor this topic, 
and we will make sure to notify GSoC Support team if this migration impacts the organization payment process.

