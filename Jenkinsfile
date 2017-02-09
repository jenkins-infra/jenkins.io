#!/usr/bin/env groovy

/* Only keep the 10 most recent builds. */
def projectProperties = [
    [$class: 'BuildDiscarderProperty',strategy: [$class: 'LogRotator', numToKeepStr: '5']],
]

if (!env.CHANGE_ID) {
    if (env.BRANCH_NAME == null) {
        projectProperties.add(pipelineTriggers([cron('H/30 * * * *')]))
    }
}

properties(projectProperties)


try {
    /* Assuming that wherever we're going to build, we have nodes labelled with
    * "Docker" so we can have our own isolated build environment
    */
    node('docker') {
        stage('Clean workspace') {
            /* Running on a fresh Docker instance makes this redundant, but just in
            * case the host isn't configured to give us a new Docker image for every
            * build, make sure we clean things before we do anything
            */
            deleteDir()
            sh 'ls -lah'
        }


        stage('Checkout source') {
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
        }


        stage('Build site') {
            /* If the slave can't gather resources and build the site in 60 minutes,
            * something is very wrong
            */
            timeout(60) {
                /* Invoke Gradle which has the actual task graph defined inside of it
                * for the building of the site
                */
                docker.image('java:8').inside {
                    /* One Weird Trick(tm) to allow git(1) to clone inside of a
                    * container
                    */
                    withEnv([
                        'GIT_COMMITTER_EMAIL=me@hatescake.com',
                        'GIT_COMMITTER_NAME=Hates',
                        'GIT_AUTHOR_NAME=Cake',
                        'GIT_AUTHOR_EMAIL=hates@cake.com',
                        /* Override the npm cache directory to avoid: EACCES: permission denied, mkdir '/.npm' */
                        'npm_config_cache=npm-cache',
                        /* set home to our current directory because other bower
                        * nonsense breaks with HOME=/, e.g.:
                        * EACCES: permission denied, mkdir '/.config'
                        */
                        'HOME=.',
                        ]) {
                        sh '''
                            set -o pipefail
                            ./gradlew --quiet --console=plain --no-daemon --info --stacktrace | tee build.log
                            if [[ -n "$( grep --fixed-strings WARNING build.log | grep --invert-match --fixed-strings "no callouts refer to list item" | grep --invert-match --fixed-strings "skipping reference to missing attribute" )" ]] ; then
                                echo "Failing build due to warnings in log output" >&2
                                exit 1
                            fi
                           '''
                    }
                }
            }
        }

        stage('Archive site') {
            /* The `archive` task inside the Gradle build should be creating a zip file
            * which we can use for the deployment of the site. This stage will archive
            * that artifact so we can pick it up later
            */
            archiveArtifacts artifacts: 'build/**/*.zip,build/_site/*.pdf', fingerprint: true
            /* stash the archived site so we can pull it back out when we deploy */
            stash includes: 'build/**/*.zip', name: 'built-site'
        }
    }

    /* The Jenkins which deploys doesn't use multibranch or GitHub Org Folders
     */
    if (env.BRANCH_NAME == null) {
        stage('Deploy sitesite') {
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
                    sh 'echo "put build/archives/*.zip archives/" | sftp  site-deployer@eggplant.jenkins.io'
                }
            }
        }
    }
}
catch (exc) {
    echo "Caught: ${exc}"

    String recipient = 'infra@lists.jenkins-ci.org'

    mail subject: "${env.JOB_NAME} (${env.BUILD_NUMBER}) failed",
            body: "It appears that ${env.BUILD_URL} is failing, somebody should do something about that",
              to: recipient,
         replyTo: recipient,
            from: 'noreply@ci.jenkins.io'
}

// vim: ft=groovy
