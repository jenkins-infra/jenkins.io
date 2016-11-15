---
:layout: post
:title: Security updates addressing zero day vulnerability
:tags:
- core
- security
:author: daniel-beck
---

A zero-day vulnerability in Jenkins was published on Friday, November 11. We [previously provided a mitigation preventing the exploit from working](/blog/2016/11/12/addressing-remote-vulnerabilities-in-cli/), and today, we are releasing updates to Jenkins that fix the vulnerability. We strongly recommend you update Jenkins to 2.32 (main line) or 2.19.3 (LTS) as soon as possible.

For more detailed information, see today's [security advisory](https://wiki.jenkins-ci.org/display/SECURITY/Jenkins+Security+Advisory+2016-11-16).

We are also revisiting the design of the Jenkins CLI over the coming weeks to prevent this class of vulnerability in the future.

Subscribe to the [jenkinsci-advisories mailing list](/content/mailing-lists) to receive further Jenkins security notifications.
