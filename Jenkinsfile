#!/usr/bin/env groovy

/* Only keep the 10 most recent builds. */
def projectProperties = [
    [$class: 'BuildDiscarderProperty',strategy: [$class: 'LogRotator', numToKeepStr: '5']],
]
def imageName = 'jenkinsciinfra/jenkinsio'

if (!env.CHANGE_ID) {
    if (env.BRANCH_NAME == null) {
        projectProperties.add(pipelineTriggers([cron('H/30 * * * *'), pollSCM('H/5 * * * *')]))
        projectProperties.add(disableConcurrentBuilds())
    }
}

properties(projectProperties)


try {
    /* Assuming that wherever we're going to build, we have nodes labelled with
    * "Docker" so we can have our own isolated build environment
    */
    node('docker&&linux') {
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
            /* If the agent can't gather resources and build the site in 60 minutes,
            * something is very wrong
            */
            timeout(60) {
                sh '''#!/usr/bin/env bash
                    set -o errexit
                    set -o nounset
                    set -o pipefail
                    set -o xtrace

                    make all

                    illegal_htaccess_content="$( find content -name '.htaccess' -type f -exec grep --extended-regexp --invert-match '^(#|ErrorDocument)' {} \\; )"
                    if [[ -n "$illegal_htaccess_content" ]] ; then
                        echo "Failing build due to illegal content in .htaccess files, only ErrorDocument is allowed:" >&2
                        echo "$illegal_htaccess_content" >&2
                        exit 1
                    fi

                    illegal_filename="$( find . -name '*[<>]*' )"
                    if [[ -n "$illegal_filename" ]] ; then
                        echo "Failing build due to illegal filename:" >&2
                        echo "$illegal_filename" >&2
                        exit 1
                    fi
                    '''
            }
        }

        def container
        stage('Build docker image'){
            timestamps {
                dir('docker'){
                    /* Only update docker tag when docker files change*/
                    def imageTag = sh(script: 'tar cf - docker | md5sum', returnStdout: true).take(6)
                    echo "Creating the container ${imageName}:${imageTag}"
                    container = docker.build("${imageName}:${imageTag}")
                }
            }
        }

        stage('Archive site') {
            /* The `archive` task inside the Gradle build should be creating a zip file
            * which we can use for the deployment of the site. This stage will archive
            * that artifact so we can pick it up later
            */
            archiveArtifacts artifacts: 'build/**/*.zip,build/_site/*.pdf', fingerprint: true
        }

        /* The Jenkins which deploys doesn't use multibranch or GitHub Org Folders
        */
        if (env.BRANCH_NAME == null) {
            stage('Publish on Azure') {
                /* -> https://github.com/Azure/blobxfer
                Require credential 'BLOBXFER_STORAGEACCOUNTKEY' set to the storage account key */
                withCredentials([string(credentialsId: 'BLOBXFER_STORAGEACCOUNTKEY', variable: 'BLOBXFER_STORAGEACCOUNTKEY')]) {
                    sh './scripts/blobxfer upload --local-path /data/_site --storage-account-key $BLOBXFER_STORAGEACCOUNTKEY --storage-account prodjenkinsio --remote-path jenkinsio --recursive --mode file --skip-on-md5-match --file-md5'
                }
            }
            stage('Publish docker image') {
                infra.withDockerCredentials {
                    timestamps { container.push() }
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

    /* Rethrow to fail the Pipeline properly */
    throw exc
}

// vim: ft=groovy
