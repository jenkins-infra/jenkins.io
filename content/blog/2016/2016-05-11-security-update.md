---
:layout: post
:title: Security updates for Jenkins core
:tags:
- core
- security
:author: daniel-beck
---
We just released security updates to Jenkins that fix a number of low and medium severity issues. For an overview of what was fixed, see the [security advisory](https://wiki.jenkins.io/display/SECURITY/Jenkins+Security+Advisory+2016-05-11).

One of the fixes may well break some of your use cases in Jenkins, at least until plugins have been adapted: SECURITY-170. This change removes parameters that are not defined on a job from the build environment. So, right now, a job could even be unparameterized, and plugins were able to pass parameters anyway. Since build parameters are added to the environment variables of scripts run during a build, parameters such as `PATH` or `DYLD_LIBRARY_PATH` can be defined -- on jobs which don't even expect those as build parameters -- to change the behavior of builds.

A number of plugins define additional parameters for builds. For example, GitHub Pull Request Builder passes a number of additional parameters describing the pull request. Release Plugin also allows adding several additional parameters to a build that are not considered to be defined in the job as part of this security fix.

Please see [this wiki page](https://wiki.jenkins.io/display/JENKINS/Plugins+affected+by+fix+for+SECURITY-170) for a list of plugins known to be affected by this change.

Until these plugins have been adapted to work with the new restriction (and advice on that is available further down), you can define the following system properties to work around this limitation, at least for a time:

* Set `hudson.model.ParametersAction.keepUndefinedParameters` to `true`, e.g. `java -Dhudson.model.ParametersAction.keepUndefinedParameters=true -jar jenkins.war` to revert to the old behavior of allowing any build parameters. Depending on your environment, this may be unsafe, as it opens you up to attacks as described above.
* Set `hudson.model.ParametersAction.safeParameters` to a comma-separated list of safe parameter names, e.g. `java -Dhudson.model.ParametersAction.safeParameters=FOO,BAR_baz,quX -jar jenkins.war`.

I realize this change, among a few others that improve the security of Jenkins, may be difficult to adapt for some, but given the valuable secrets typically stored in Jenkins, I'm certain that this is the correct approach. We made sure to release this fix with the options described above, so that this change doesn't block updating those that rely on this behavior.

Developers have several options to adapt to this change:

* `ParametersAction` actually stores all parameters, but `getParameters()` only returns those that are defined on the job. The new method `getAllParameters()` returns all of them. This can be used, for example by `EnvironmentContributor` extensions, to add known safe parameters to build environments.
* Don't pass extra arguments, but define a `QueueAction` for your metadata instead. Those can still be made available to the build environment as needed.

Subscribe to the [jenkinsci-advisories mailing list](/content/mailing-lists) to receive important notifications related to Jenkins security.
