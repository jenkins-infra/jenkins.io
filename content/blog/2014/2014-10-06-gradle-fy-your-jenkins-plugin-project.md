---
:layout: post
:title: Gradle-fy your Jenkins Plugin Project
:nodeid: 512
:created: 1412637141
:tags:
- general
- guest post
- plugins
:author: kohsuke
---
(This is a guest post from [Daniel Spilker](https://web.archive.org/web/20180520134954/http://www.daniel-spilker.com/))

Jenkins supports building plugins using [Gradle](https://www.gradle.org/) for a while now. Last week a new version of the [Gradle JPI plugin](https://wiki.jenkins-ci.org/display/JENKINS/Gradle+JPI+Plugin) has been released to iron out some [issues](https://github.com/jenkinsci/gradle-jpi-plugin/blob/0.6.0/CHANGELOG.md).

The Gradle JPI plugin enables a 100% groovy plugin development environment with Groovy as primary programming language, [Spock](https://code.google.com/p/spock/) for writing tests and Gradle as build system. Have a look at the [Job DSL plugin](https://github.com/jenkinsci/job-dsl-plugin) for an example.

An existing Maven build can be converted to Gradle by using the build.gradle template from the Gradle JPI plugin's [README](https://github.com/jenkinsci/gradle-jpi-plugin/blob/master/README.md). For instance, the [POM](https://github.com/jenkinsci/gradle-plugin/blob/763256601be20c30d238179c1ed3965011d6dfd5/pom.xml) from the [Gradle plugin](https://wiki.jenkins-ci.org/display/JENKINS/Gradle+Plugin) translates to this build.gradle file:

    buildscript {
        repositories {
            mavenCentral()
            maven {
                url 'https://repo.jenkins-ci.org/releases/'
            }
        }
        dependencies {
            classpath 'org.jenkins-ci.tools:gradle-jpi-plugin:0.6.0'
        }
    }

    apply plugin: 'jpi'

    group = 'org.jenkins-ci.plugins'
    version = '1.25-SNAPSHOT'

    jenkinsPlugin {
        coreVersion = '1.480'
        displayName = 'Jenkins Gradle plugin'
        url = 'https://wiki.jenkins-ci.org/display/JENKINS/Gradle+Plugin'
        gitHubUrl = 'https://github.com/jenkinsci/gradle-plugin'

        developers {
            developer {
                id 'gbois'
                name 'Gregory Boissinot'
                timezone '+1'
            }
        }                           
    }

    dependencies {
        compile 'org.jenkins-ci.lib:dry-run-lib:0.1'
    }

Usage of the Gradle JPI plugin is similar to working with the Maven HPI plugin. Use `gradle jpi` to build the plugin file. `gradle check` runs the tests, `gradle install` copies the plugin into the local Maven repository, `gradle uploadArchives` deploys the plugin to the Jenkins Maven repository and `gradle server` starts a Jenkins development server with the plugin installed.

It is recommended to use Gradle 1.8 because that is the version used to build and test the Gradle JPI plugin.

For the next release it is planned to do some maintenance like fixing code style issues and adding tests. After that more issues need to be addressed to bring the plugin on par with the Maven HPI plugin, most notably fixing the test dependencies ([JENKINS-17129](https://issues.jenkins-ci.org/browse/JENKINS-17129)) and publishing the plugin's JAR ([JENKINS-25007](https://issues.jenkins-ci.org/browse/JENKINS-25007)). Updating Gradle to 2.x and getting the plugin on the [Gradle plugin portal](https://plugins.gradle.org/) is also on the wishlist.
