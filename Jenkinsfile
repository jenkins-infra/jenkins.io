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
                sh '''#!/usr/bin/env bash
                    set -o errexit
                    set -o nounset
                    set -o pipefail
                    set -o xtrace
                    make all | tee build.log
                    if [[ -n "$( grep --fixed-strings WARNING build.log | grep --fixed-strings --invert-match user-handbook.adoc )" ]] ; then
                        echo "Failing build due to warnings in log output" >&2
                        exit 1
                    fi

                    illegal_htaccess_content="$( find content -name '.htaccess' -type f -exec grep --extended-regexp --invert-match '^(#|ErrorDocument)' {} \\; )"
                    if [[ -n "$illegal_htaccess_content" ]] ; then
                        echo "Failing build due to illegal content in .htaccess files, only ErrorDocument is allowed:" >&2
                        echo "$illegal_htaccess_content" >&2
                        exit 1
                    fi
                    '''
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
            stage('Deploy site') {
                /* This Credentials ID is from the `site-deployer` account on
                * ci.jenkins-ci.org
                *
                * Watch https://issues.jenkins-ci.org/browse/JENKINS-32101 for updates
                */
                sshagent(credentials: ['site-deployer']) {
                    sh 'ls build/archives'
                    sh 'echo "put build/archives/*.zip archives/" | sftp -o StrictHostKeyChecking=no site-deployer@eggplant.jenkins.io'
                }
            }
            stage('Publish on Azure') {
                /* -> https://github.com/Azure/blobxfer
                Require credential 'BLOBXFER_STORAGEACCOUNTKEY' set to the storage account key */
                withCredentials([string(credentialsId: 'BLOBXFER_STORAGEACCOUNTKEY', variable: 'BLOBXFER_STORAGEACCOUNTKEY')]) {
                    sh './scripts/blobxfer upload --local-path /data/_site --storage-account-key $BLOBXFER_STORAGEACCOUNTKEY --storage-account prodjenkinsio --remote-path jenkinsio --recursive --mode file --skip-on-md5-match --file-md5'
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
