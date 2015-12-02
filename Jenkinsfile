
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
    /* If the slave can't gather resources and build the site in 30 minutes,
     * something is very wrong
     */
    timeout(30) {
        /* Invoke Gradle which has the actual task graph defined inside of it
         * for the building of the site
         */
        sh './gradlew --no-color --no-daemon --info --stacktrace'
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


// vim: ft=groovy
