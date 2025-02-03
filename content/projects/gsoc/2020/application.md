---
:layout: simplepage
:title: "Jenkins GSoC application draft, 2020"
:tags:
- gsoc
- gsoc2020
---

<!-- This file uses Markdown intentionally.
     Google's GSoC site uses Markdown as an engine, using Markdown here allows copy-pasting
 -->

The data below represents the 2020 GSoC application.

### Organization Profile

* Website URL: https://jenkins.io/
* Tagline (up to 80 symbols): Open-source automation server for building great things at any scale
* Technology tags (max 5):
  * java
  * javascript
  * docker
  * kubernetes
  * go
* Topic Tags (max 5)
  * continuous integration
  * continuous delivery
  * developer tools
  * devops
  * automation
* Ideas list: https://jenkins.io/projects/gsoc/2020/project-ideas/
* Primary open-source license: MIT License
* Category: Programming Languages and Development tools
* Logo: https://wiki.jenkins.io/download/attachments/2916393/logo-title.png

#### Short description

Jenkins is a popular open source automation server which used is for building, testing, CI/CD, deployment and many other use-cases.
Our motto is "Build great things at any scale".

#### Long description (Markdown)

[Jenkins](https://jenkins.io/), originally founded in 2006 as "Hudson", is one of the leading automation servers. 
Jenkins' motto is "Build great things at any scale".
Using an extensible, plugin-based architecture developers have created hundreds of plugins to adapt Jenkins to a multitude of build, test, and deployment automation workloads. 
Jenkins is open-source, [MIT License](https://www.opensource.org/licenses/mit-license.php) is used for most of the components.

This year we invite students to join the Jenkins community and to work together to improve Jenkins user experience and reliability.
We have many strategic project ideas which are important to hundreds of thousands of Jenkins users.

The project has about 600 active contributors working on Jenkins core, plugins, website, project infrastructure, localization activities, etc.
In total we have more than 2000 components including plugins, libraries, and various utilities. 
The main languages in the project are Java, Groovy and JavaScript,
but we also have components written in other languages (Go, C/C++, C#, etc.).
Jenkins project includes multiple
[sub-projects](https://jenkins.io/projects/) (including 
[Configuration-as-Code](https://jenkins.io/projects/jcasc/),
[Infrastructure](https://jenkins.io/projects/infrastructure/)
and [Remoting](https://jenkins.io/projects/remoting/)) and 
[special interest groups](https://jenkins.io/sigs/).
These entities participate in GSoC as a part of the Jenkins project.
[Jenkins X](https://jenkins-x.io/) also participates in GSoC under umbrella of the Jenkins project.

Jenkins project is a part of [Continuous Delivery Foundation (CDF)](https://cd.foundation/).
CDF also participates in Google Summer of Code this year as an umbrella organization for all its projects except Jenkins and Jenkins X ([org profile](https://summerofcode.withgoogle.com/organizations/5550056498790400/)).

#### Proposal process

First of all, thanks for your interest!
In order to apply to the organization, please follow the [guidelines on our website](https://jenkins.io/projects/gsoc/students/#student-application-process).

Before submitting please go through the [GSoC student guide](https://google.github.io/gsocgides/student/)
and through [our student guide](https://jenkins.io/projects/gsoc/students/) which documents the Jenkins specifics.
Participating in Google Summer of Code is a major time commitment requiring an almost full-time dedication over several months.
If it may overlap with your study, internship, work or other commitments, we recommend to think twice before applying.

If you have any questions about the application process,
please feel free to contact us via the [jenkinsci/gsoc-sig Gitter chat](https://app.gitter.im/#/room/#jenkinsci_gsoc-sig:gitter.im).
We also have [weekly meetings](https://jenkins.io/projects/gsoc/#office-hours) which are open to everyone.

#### Proposal tags (max - 10)

TODO: Adjust according to project ideas

* user experience
* plugins
* performance
* tools
* REST API
* cloud technologies
* configuration-as-code
* Jenkins X
* machine learning
* electronic design automation

#### Contacts

* Chat page URL: https://app.gitter.im/#/room/#jenkinsci_gsoc-sig:gitter.im
* Twitter: https://twitter.com/jenkinsci
* Blog: https://jenkins.io/blog/

### Application

#### Why does your org want to participate in Google Summer of Code?

In our community we are interested to have more contributors in both the Jenkins core and 1,700+ existing plugins. 
We consider GSoC as an opportunity to find new contributors and students interested in software development automation (continuous integration and continuous delivery).
It also helps to get existing contributors more involved into the community work.
We have previously participated in GSoC 2016-2019 and got much experience from it, especially regarding the student selection process.
We hope this will help us to improve student/mentor experience and overall results this year.

#### How many potential mentors have agreed to participate?

16-20

#### How will you keep mentors engaged with their students?

* We have explicit expectations from mentors, they are documented in [our mentor guidelines](https://jenkins.io/projects/gsoc/mentors). All mentors commit on these expectations during the project selection.
* Each student project will have at least 2+ mentors AND an org admin advisor assigned to the project.
* Mentors are expected to be accomplished Jenkins contributors, who are passionate about the community/mentorship work.
* Mentors bring their own project, and they are expected to have a high interest in it
* Mentors will be directly involved into student selection and interview processes so they will establish connection with successful students early
* We conduct [weekly meetings](https://jenkins.io//projects/gsoc/#office-hours) between mentors and org admins to sync-up on progress and any issues
* Org admins will be monitoring mentor/student interaction starting from the application phase and intervene if needed
* There will be regular sync-ups between org admins and mentors


#### How will you help your students stay on schedule to complete their projects?

* During the Application phase and Community Bonding phase mentors will share their expertise to define realistic project plans.
* The student project milestones will be discussed and confirmed between mentors and students. 
  Milestones will be aligned with student evaluations and will have clear expectations set up.
* Mentors will set up regular meetings with students (at least twice per week) in order to sync-up on projects. 
  We expect retrospectives with students after each evaluation.
* Mentors should be available for questions. 
  They should also provide a periodic feedback on the progress and on the performance of particular students (1x1).
* We will set up weekly public office-hours with students (or two meetings if time-zones require it) and private ones between mentors and org admins to sync-up
* We will be requiring a daily push to branches so that the students always show the progress and keep changes atomic.

<!-- DOES NOT FIT form size 
* During the coding period, mentors will participate in the code reviews of their student and report to org admins if the project stalls.
-->

#### How will you get your students involved in your community during GSoC?

* Students will cooperate with Jenkins community during the project.
  Community Bonding will be a critical phase for us.
* Projects will handled under an umbrella of
  [SIGs](https://jenkins.io/sigs) or [sub-projects](https://jenkins.io/projects)
  so that there is a number of non-mentor stakeholders and early adopters
* Students will be participating in sub-project/SIG meetings and presenting their work on a regular basis
* Org Admins will provide an introductory training (community overview, code-of-conduct, etc.), 
  then mentors will help students to establish contacts with experts from the community
* We expect students to be around in public chats and other communication channels during the “working days”
* Students will be involved into all standard processes in our community (pull requests, code reviews, chats and mailing lists, test automation, documentation, online meetups, etc.).
* Students will be encouraged to give updates to the wider community in the Jenkins blog

#### How will you keep students involved with your community after GSoC?

* We plan to sponsor successful students' travel and attendance at a Jenkins-focused conference and/or contributor summit.
  The projects will be also presented at the [Jenkins Online Meetup](https://www.meetup.com/Jenkins-online-meetup/).
* Students will be developing their own modules for Jenkins and effectively they will retain ownership of these modules after GSoC (they can opt-out, of course).
  Public presentations will attract attention, and the students will be periodically contacted by users.
* Students will be also advised to present their projects at local meetups
* Each project will have a strict Definition Of Done: public availability, Q&A chats, [blog posts on the project website](https://jenkins.io/blog/).
* We recommend mentors to have monthly sync-ups with the students to follow-up on projects and other events in Jenkins
* We will invite students to participate in other community outreach activities like GSoC or Hacktoberfest

#### Has your org been accepted as a mentoring org in Google Summer of Code before?

Yes, in 2016, 2018 and 2019

* 2019: 5/7
* 2018: 2/3 (+1 cancelled project during community bonding)
* 2016: 1/5 (3 students have been failed due to major undisclosed time commitments, which impacted the project quality at the first coding phase)

### Is there an organization new to GSoC that you would like to refer to the program for 2020? Feel free to add a few words about why they'd be a good fit.

TODO

#### If your org has applied for GSoC before but not been accepted, select the years
2009, 2017

#### If you are a new organization to GSoC, is there a Google employee or previously participating organization who will vouch for you? If so, please enter their name, contact email, and relationship to your organization. (optional)

EMPTY

#### What year was your project started?

2006

#### Where does your source code live

https://github.com/jenkinsci/ ,
https://github.com/jenkins-x/ ,
https://github.com/jenkins-infra/ ,
https://github.com/jenkins-zh/

#### Is your organization part of any government?

No

#### Are you part of a foundation/umbrella organization?
Yes, Jenkins is transitioning between two organizations at this time:

* Software in the Public Interest, Inc. (https://spi-inc.org) a 501 (c) (3) non-profit organization
* Continuous Delivery foundation (https://cd.foundation/about/), a non-profit Linux Foundation organization

#### Anything else we should know (optional)?

The Jenkins project is migrating from Software in the Public Interest, Inc. (https://spi-inc.org) to Continuous Delivery Foundation (https://cd.foundation/about/) this year. 
GSoC org admins closely monitor this topic, 
and we will change the payment instructions for the project.
