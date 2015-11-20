node {
    stage 'Checkout source'
    /*
     * For a standalone workflow script, we would use the `git` step
     */
    git url: 'git://github.com/jenkinsci/jenkins.io',
        branch: 'master'

    /*
     * Represents the SCM configuration in a "Workflow from SCM" project build. Use checkout
     * scm to check out sources matching Jenkinsfile with the SCM details from
     * the build that is executing this Jenkinsfile.
     */
    /* https://issues.jenkins-ci.org/browse/JENKINS-31386 */
    // checkout scm


    stage 'Build site'
    sh './gradlew -Si'
}
