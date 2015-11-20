node {
  /*
   * For a standalone workflow script, we would use the `git` step
   * git 'git://github.com/jenkinsci/jenkins.io'
   */

  /*    
   * Represents the SCM configuration in a "Workflow from SCM" project build. Use checkout
   * scm to check out sources matching Jenkinsfile with the SCM details from
   * the build that is executing this Jenkinsfile.
   */
  checkout scm

  sh './gradlew -Si'
}
