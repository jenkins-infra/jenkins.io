---
:layout: post
:title: Security Fix! Hudson 1.365 Released
:nodeid: 223
:created: 1278432590
:tags:
- general
- core
- news
- releases
:author: rtyler
---
The Hudson team has released Hudson 1.365 which contains a critical security fix! A security advisory [released yesterday by InfraDNA](https://infradna.com/content/security-advisory-2010-07-05) goes on to explain the hole with more detail:

>This vulnerability allows an attacker to read arbitrary files in the
server file system whose path names are known, by sending malicious
HTTP GET requests. While such access is still subject to the normal
access control enforced by the operating system, Hudson can still leak
"secrets" possessed by Hudson

The vulnerability inside of Hudson affects Hudson instances running inside the embedded Winstone container, instances behind Glasshfish or Jetty (for example) are not subject to this vulnerability. Instances running behind a reverse proxy such as mod_proxy or Nginx.

Hudson system administrators should subscribe to either the [security advisories RSS feed](https://feeds.feedburner.com/hudson-security-advisories) or the [advisories@ mailing list](/mailing-lists/#jenkinsci-advisories-googlegroups-com)


----

You can go grab the [latest .war file](https://ftp.osuosl.org/pub/hudson/war/1.363/hudson.war) straight from our [OSL mirror](https://www.osuosl.org) or if you're using a native package, use your package manager to upgrade.
