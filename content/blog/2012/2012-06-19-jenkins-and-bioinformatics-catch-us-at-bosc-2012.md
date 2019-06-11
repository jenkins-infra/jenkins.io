---
:layout: post
:title: Jenkins and Bioinformatics, catch us at BOSC 2012
:nodeid: 386
:created: 1340118000
:tags:
- general
- cia
- meetup
:author: rtyler
---
[ **Editor's Note:** *The following is a post from [Jenkins CIA](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CIA+Program) member [Bruno P. Kinoshita](https://kinoshita.eti.br)* ]

Jenkins will be represented at this years Bioinformatics Open Source Conference ([BOSC 2012](https://www.open-bio.org/wiki/BOSC_2012 "BOSC 2012")) on July 13-14th in Long Beach, California. I will be talking about Jenkins during my talk about [BioUno](https://www.biouno.org "BioUno"). 

BOSC 2012 will be held just before [ISMB 2012](https://www.iscb.org/ismb2012), while registration is through ISMB you don't have to register for ISMB in order to register for BOSC.

I will be at the event with some Jenkins stickers and available to answer questions you might have about BioUno and Jenkins!

### About BioUno

BioUno is a project that uses Jenkins as basis for building
[biology workflows](https://en.wikipedia.org/wiki/Bioinformatics_workflow_management_systems "Bioinformatics Workflow Management Systems Wiki entry").
BioUno provides an alternative update center with custom plug-ins for
bioinformatics tools like
[MrBayes](https://mrbayes.sourceforge.net/ "MrBayes"),
[Structure](https://pritch.bsd.uchicago.edu/structure.html "Structure"),
[Figtree](https://tree.bio.ed.ac.uk/software/figtree/ "Figtree"),
[Beast](http://beast.community/ "Beast"),
among [others](https://www.biouno.org/biouno-plugins/ "BioUno Plug-ins").

While the actual task of analysing or displaying data is handled by specific
tools, that are wrapped by plug-ins, Jenkins is responsible for user control,
web interface, notifications, distributed execution, job schedule and
management, as well as other important low level tasks.

BioUno is similar to [BioHPC](http://biohpc.org/ "BioHPC"),
[Galaxy](https://galaxy.psu.edu/ "Galaxy") and
[Taverna](https://taverna.incubator.apache.org/ "Taverna"), in that all these tools enable creating and managing pipelines using different bioinformatics tools.

However, as it is using Jenkins, BioUno has the advantage of having an Open Source community of hackers that can answer questions and provide assistance for creating new plug-ins. There is plenty documentation for [extending Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Extend+Jenkins "Extending Jenkins")
and troubleshooting issues, as well as plenty [existing plug-ins](https://wiki.jenkins-ci.org/display/JENKINS/Plugins "Jenkins Plug-ins") (that can be used as reference while writing new plug-ins).

There are projects and plug-ins that enable Jenkins to use resources in clouds or turn Jenkins into a [Hadoop](https://hadoop.apache.org/ "Hadoop") node, for big data processing. The next steps of the project include the deployment of BioUno to a computer facility, basic infrastructure for BioUno, definition of the process for releasing plug-ins, the creation of more plug-ins and a study on how to handle large data structures, used by many bioinformatics tools. 

The project is being developed by [TupiLabs](http://tupilabs.com "TupiLabs") under MIT License, and contributions and new plug-ins are welcome.
<!--break-->
