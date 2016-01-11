---
:layout: post
:title: Workflow Best Practices and Examples repo on GitHub
:nodeid: 651
:created: 1450284977
:tags:
- general
- jenkinsci
- pipeline
- workflow
:author: abayer
---
A lot of people are using the [Workflow plugin](https://github.com/jenkinsci/workflow-plugin/blob/master/README.md), but as with any scripting environment, users often have to start from scratch and learn the same lessons and shortcuts that other users have already learned. While there are blog posts from developers and users in various places, and some samples in the Workflow plugin documentation, more examples and tips and tricks are always, always useful. To help with that, we've created the *[workflow-examples](https://github.com/jenkinsci/workflow-examples)* repository on GitHub, as a place to store community-developed Workflow scripts that can help new users get started, show how to accomplish some non-trivial goals, and find tips and trick for taking your Workflow pipeline to the next level. 

The repository has four directories:

*  `docs/` - documentation, guides, and more. Including a [Best Practices document](https://github.com/jenkinsci/workflow-examples/blob/master/docs/BEST_PRACTICES.md). We'd love to see more contributions to that doc, as well as any new ones that would be helpful to Workflow users!
*  `workflow-examples/` - general Workflow examples, showing how to use a given plugin with Workflow, quirks of the Workflow DSL syntax, and more.
*  `global-library-examples/` - examples of how to write code for [the Workflow global library](https://github.com/jenkinsci/workflow-plugin/blob/master/cps-global-lib/README.md).
*  `jenkinsfile-examples/` - Sample [Jenkinsfiles](https://github.com/jenkinsci/workflow-plugin/blob/master/TUTORIAL.md#creating-multibranch-projects) or other Workflow scripts from SCM .

During [Hacksgiving](/content/hacksgiving-left-overs) some initial content was added, but not everything is covered yet, which is why I'm posting this - more is needed. We'd love to see your tips, examples, gotchas and more. If you've got Workflow scripts you'd like to contribute, please read the [README](https://github.com/jenkinsci/workflow-examples#introduction) and send a [pull request](https://github.com/jenkinsci/workflow-examples/pulls). Thanks!
