---
:layout: post
:title: Mitigating unauthenticated remote code execution 0-day in Jenkins CLI
:nodeid: 647
:created: 1446858787
:tags:
- general
- core
- news
:author: rtyler
---
**Updated 2015-11-11 15:00 UTC:** We have released Jenkins 1.638 and 1.625.2 which contain a fix for this vulnerability. [See the security advisory for more information about these releases](https://wiki.jenkins-ci.org/display/SECURITY/Jenkins+Security+Advisory+2015-11-11).

---

**Updated 2015-11-06 03:55 UTC:** Included a updated mitigation script which doesn't have a Jenkins boot race condition

---

Earlier today we received numerous reports about a previously undisclosed "[zero day](https://en.wikipedia.org/wiki/Zero-day_%28computing%29)" critical remote code execution vulnerability and exploit in Jenkins core. Unfortunately the vulnerability was not disclosed to us ahead of its publication so we're still working on more thorough fix. In the *meantime* however, we wanted to inform you of the issue and provide a workaround which will help prevent this exploit from being used against public Jenkins installations, for future reference this issue is being tracked privately as `SECURITY-218` in our [issue tracker](https://issues.jenkins-ci.org).

The attack is mounted through the [Jenkins CLI](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CLI) subsystem, so the work-around is to remove/disable the CLI support inside of the running Jenkins server.

Using the following Groovy script you can disable the attack vector in your Jenkins installations by navigating to “Manage Jenkins” and then to “Script Console”, or just go to `+http://your-jenkins-installation/script+`. This only addresses the current running Jenkins process, in order to make the workaround persist between restarts of the Jenkins server, add the script below to `$JENKINS_HOME/init.groovy.d/cli-shutdown.groovy` (create the directory if necessary, and the file).

---

    import jenkins.*;
    import jenkins.model.*;
    import hudson.model.*;

    // disabled CLI access over TCP listener (separate port)
    def p = AgentProtocol.all()
    p.each { x ->
      if (x.name.contains("CLI")) p.remove(x)
    }

    // disable CLI access over /cli URL
    def removal = { lst ->
      lst.each { x -> if (x.getClass().name.contains("CLIAction")) lst.remove(x) }
    }
    def j = Jenkins.instance;
    removal(j.getExtensionList(RootAction.class))
    removal(j.actions)


---
 in order to make the workaround persist between restarts of the Jenkins server, add the script below to `$JENKINS_HOME/init.groovy.d/cli-shutdown.groovy` (create the directory if necessary, and the file).

The latest version of this script can be found [in this GitHub repository](https://github.com/jenkinsci-cert/SECURITY-218).

As previously announced on the [jenkinsci-advisories](https://groups.google.com/d/forum/jenkinsci-advisories) mailing list we’re preparing a security release for this upcoming Wednesday which will include patches for both the latest and LTS lines of Jenkins core. The Jenkins Security team is working to include a fix for this previously undisclosed exploit in or before this planned security release.


If you have questions about this exploit, join us in the [#jenkins channel on Freenode](http://webchat.freenode.net/?channels=%23jenkins&uio=d4) or ask on the [jenkinsci-users@ mailing list](https://groups.google.com/d/forum/jenkinsci-users).


For security researchers and hobbyists, if you believe you have found a security vulnerability in Jenkins, we have some disclosure guidelines [on this wiki page](https://wiki.jenkins-ci.org/display/JENKINS/Security+Advisories) which will help us mitigate any discovered issues as quickly and safely as possible.

---

Be sure to subscribe to the jenkinsci-advisories mailing list ([jenkinsci-advisories](https://groups.google.com/d/forum/jenkinsci-advisories)), it's the fastest way to get updates by the Jenkins Security team.
