#!/usr/bin/env groovy

/* Only keep the 10 most recent builds. */
properties([[$class: 'BuildDiscarderProperty',
                strategy: [$class: 'LogRotator', numToKeepStr: '10']]])


try {
    /* Assuming that wherever we're going to build, we have nodes labelled with
    * "Docker" so we can have our own isolated build environment
    */
    node('docker') {
        stage 'Clean workspace'
        /* Running on a fresh Docker instance makes this redundant, but just in
        * case the host isn't configured to give us a new Docker image for every
        * build, make sure we clean things before we do anything
        */
        deleteDir()
        sh 'ls -lah'


        stage 'Checkout source'
        /*
        * For a standalone workflow script, we would use the `git` step
        *
        *
        * git url: 'git://github.com/jenkinsci/jenkins.io',
        *     branch: 'master'
        */

        /*
        * Represents the SCM configuration in a "Workflow from SCM" project build. Use checkout
        * scm to check out sources matching Jenkinsfile with the SCM details from
        * the build that is executing this Jenkinsfile.
        *
        * when not in multibranch: https://issues.jenkins-ci.org/browse/JENKINS-31386
        */
        checkout scm


        stage 'Build site'
        /* If the slave can't gather resources and build the site in 60 minutes,
        * something is very wrong
        */
        timeout(60) {
            /* Invoke Gradle which has the actual task graph defined inside of it
            * for the building of the site
            */
            withJavaEnv {
                sh './gradlew --console=plain --no-daemon --info --stacktrace'
            }
        }


        stage 'Archive site'
        /* The `archive` task inside the Gradle build should be creating a zip file
        * which we can use for the deployment of the site. This stage will archive
        * that artifact so we can pick it up later
        */
        archive 'build/**/*.zip'
        /* stash the archived site so we can pull it back out when we deploy */
        stash includes: 'build/**/*.zip', name: 'built-site'

    }

    stage 'Deploy beta site'
    node {
        /* This Credentials ID is from the `site-deployer` account on
        * ci.jenkins-ci.org
        *
        * Watch https://issues.jenkins-ci.org/browse/JENKINS-32101 for updates
        */
        sshagent(credentials: ['site-deployer']) {
            /* Make sure we delete our current directory on this node to make sure
            * we're only uploading what we unstash
            */
            deleteDir()
            unstash 'built-site'
            sh 'ls build/archives'
            parallel(
                eggplant: {
                    sh 'echo "put build/archives/*.zip archives/" | sftp  site-deployer@eggplant.jenkins.io'
                },
                cucumber: {
                    sh 'echo "put build/archives/*.zip archives/" | sftp site-deployer@cucumber.jenkins.io'
                })
        }
    }
}
catch (exc) {
    String recipient = 'infra@lists.jenkins-ci.org'

    mail subject: "${env.JOB_NAME} (${env.BUILD_NUMBER}) failed",
            body: "It appears that ${env.BUILD_URL} is failing, somebody should do something about that",
              to: recipient,
         replyTo: recipient,
            from: 'noreply@ci.jenkins.io'
}

/* This code shame-lessly copied and pasted from some Jenkinsfile code abayer
   wrote for the jenkinsci/jenkins project */
void withJavaEnv(List envVars = [], def body) {
    String jdktool = tool name: "jdk8", type: 'hudson.model.JDK'

    // Set JAVA_HOME, and special PATH variables for the tools we're
    // using.
    List javaEnv = ["PATH+JDK=${jdktool}/bin", "JAVA_HOME=${jdktool}"]

    // Add any additional environment variables.
    javaEnv.addAll(envVars)

    // Invoke the body closure we're passed within the environment we've created.
    withEnv(javaEnv) {
        body.call()
    }
}


// vim: ft=groovy
