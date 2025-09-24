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
            recordIssues(tools: [sarif(id: 'typos', name: 'Typos', pattern: 'typos.sarif')],
                         qualityGates: [[threshold: 1, type: 'TOTAL', unstable: true]])
        }
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

                illegal_filename="$( find . -name '*[<>]*' )"
                if [[ -n "$illegal_filename" ]] ; then
                    echo "Failing build due to illegal filename:" >&2
                    echo "$illegal_filename" >&2
                    exit 1
                fi
                '''
        }
    }

    /* The Jenkins which deploys doesn't use multibranch or GitHub Org Folders.
    */
    if (infra.isTrusted() && env.BRANCH_NAME == null) {
        parallel 'Publish Site (new)': {
            stage('Stash Site') {
                stash includes: 'build/_site/**', name: 'site'
            }
            stage('Deploy Site') {
                node('updatecenter') {
                    unstash 'site'
                    sh '''
                    rsync --recursive --links --times -D --checksum --verbose \
                        ./build/_site/ `# Source` \
                        /data-storage-jenkins-io/www.jenkins.io/ `# Destination`
                    '''
                }
            }
        },
        'Publish Site (old)': {
            try {
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
                    '''
                }
            } catch (err) {
                currentBuild.result = 'FAILURE'
                // Only collect azcopy log when the deployment fails, because it is an heavy one
                sh '''
                # Retrieve azcopy logs to archive them
                cat /home/jenkins/.azcopy/*.log > azcopy.log
                '''
                archiveArtifacts 'azcopy.log'
            }
        }
        stage('Purge pages on CDN') {
            withCredentials([
                string(credentialsId: 'fastly-api-token-purge', variable: 'FASTLY_API_TOKEN'),
            ]) {
                // Purge cache for pages which usually requires some time before being updated
                sh '''
                curl --silent --location --request PURGE --header "Fastly-Key: ${FASTLY_API_TOKEN}" https://www.jenkins.io/css/jenkins.css
                curl --silent --location --request PURGE --header "Fastly-Key: ${FASTLY_API_TOKEN}" https://www.jenkins.io/stylesheets/styles.css
                '''
            }
        }
    }
}
// vim: ft=groovy
