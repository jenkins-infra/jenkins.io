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
        * when not in multibranch: https://issues.jenkins.io/browse/JENKINS-31386
        */
        checkout scm
    }

    stage('Checks') {
        /* The Jenkins which deploys doesn't use multibranch or GitHub Org Folders.
         * Checks are advisory only.
         * They are intentionally skipped when preparing a deployment.
        */
        if (!infra.isTrusted() && env.BRANCH_NAME != null) {
            sh 'make check'
            recordIssues(tools: [checkStyle(id: 'typos', name: 'Typos', pattern: 'checkstyle.xml')],
                         qualityGates: [[threshold: 1, type: 'TOTAL', unstable: true]])
        }
    }

    stage('Build site') {
        /* If the agent can't gather resources and build the site in 60 minutes,
        * something is very wrong
        */
        timeout(60) {
            // Need to authenticate on DockerHub with a read-only account to avoid rate limit
            infra.withDockerCredentials {
                sh '''#!/usr/bin/env bash
                    set -o errexit
                    set -o nounset
                    set -o pipefail
                    set -o xtrace
    
                    make all
    
                    illegal_filename="$( find . -name '*[<>]*' )"
                    if [[ -n "$illegal_filename" ]] ; then
                        echo "Failing build due to illegal filename:" >&2
                        echo "$illegal_filename" >&2
                        exit 1
                    fi
                    '''
            }
        }
    }

    /* The Jenkins which deploys doesn't use multibranch or GitHub Org Folders.
    */
    if (infra.isTrusted() && env.BRANCH_NAME == null) {
        stage('Publish site') {
            infra.withFileShareServicePrincipal([
                servicePrincipalCredentialsId: 'trustedci_jenkinsio_fileshare_serviceprincipal_writer',
                fileShare: 'jenkins-io',
                fileShareStorageAccount: 'jenkinsio'
            ]) {
                sh '''
                # Don't output sensitive information
                set +x

                # Synchronize the File Share content
                azcopy sync \
                    --skip-version-check \
                    --recursive=true\
                    --delete-destination=true \
                    --compare-hash=MD5 \
                    --put-md5 \
                    --local-hash-storage-mode=HiddenFiles \
                    ./build/_site/ "${FILESHARE_SIGNED_URL}"

                # Retrieve azcopy logs to archive them
                cat /home/jenkins/.azcopy/*.log > azcopy.log
                '''
                archiveArtifacts 'azcopy.log'
            }
        }
        stage('Purge cached CSS') {
            sh '''
            curl --request PURGE https://www.jenkins.io/css/jenkins.css
            curl --request PURGE https://www.jenkins.io/stylesheets/styles.css
            '''
        }
    }
}

// vim: ft=groovy
