---
:layout: post
:title: 'Plugin Spotlight: Version Column Plugin'
:nodeid: 620
:created: 1441069108
:tags:
- general
- plugins
:author: daniel-beck
---
Most Jenkins masters with a [distributed build](https://wiki.jenkins.io/display/JENKINS/Distributed+builds) configuration will leverage nodes that run a `agent.jar` to start an agent. Regardless of whether the `agent.jar` is launched through a Java Web Start or SSH launcher, the jar will be copied from `+https://yourserver:port/jnlpJars/agent.jar+` to the build node. Keeping this jar up to date ensures that it picks up the newest features in a more recent release, such as the [self-restart feature](https://jenkins-ci.org/content/your-java-web-start-slaves-will-be-always-clean) to keep agent JVMs “clean” and to automatically reconnect to their master. Additionally, newer versions of this component may fix bugs or implement newer protocol versions with various improvements.

## What is the Version Column Plugin?
Launch methods designed to pull the latest `agent.jar` [are not always reliable](https://issues.jenkins-ci.org/browse/JENKINS-16490) and some launch methods don’t even try to update the `agent.jar`. Therefore it can be useful to see what `agent.jar` version is running on a given build node and take offline any nodes which fails to update to the latest version of the jar.

The Version Column Plugin allows Jenkins masters to do just this, adding a new column to the “Manage Nodes” view and a new option for version enforcement on the node configuration screen.

## Getting started
After installing the Version Column Plugin, navigate to the list of nodes in your Jenkins instance by clicking *Build Executor Status* in the executors widget below the side panel on the Jenkins home page.

If the plugin installed successfully, you will see a new column simply called “Version”. This column displays the version of the `agent.jar` that each build node is using.

![](/sites/default/files/images/versioncolumn-plugin-screenshot-1-2.png)

This column is simply displaying the versions, so enforcement of `agent.jar` versions will need to be configured elsewhere. To activate this, click on the “Configure” link in the node manager’s left-hand menu.

You will then see a set of options for agents. To activate version enforcement, check the “Version” box and apply your changes.

![](/sites/default/files/images/versioncolumn-plugin-screenshot-2.png)

When you update Jenkins, there’s a chance it’ll come with a new version of `agent.jar`. Now if the `agent.jar` on a particular agent doesn’t get updated automatically, the master will take it offline and show a warning next to the out-of-date agent version number:

![](/sites/default/files/images/versioncolumn-plugin-screenshot-3.png)

The Version Column Plugin is available for download in the Jenkins plugin manager or from [its wiki page](https://wiki.jenkins.io/display/JENKINS/VersionColumn+Plugin).
