---
:layout: post
:title: Recent label and matrix project improvement
:nodeid: 242
:created: 1283428800
:tags:
- development
- core
- tutorial
:author: kohsuke
---
Today, I’d highlight two recent improvements to the label and matrix projects.

When you have multiple slaves in your Hudson build farm, you can use labels to classify slaves by their capability/environment/architecture/etc. For example, your one slave might have “32bit” and “windows” label, while another one might have “linux”, “ubuntu”, and “64bit.” (with plugins like <a href=”https://wiki.jenkins.io/display/JENKINS/PlatformLabeler+Plugin”>platform-labeler plugin</a>, you can attach labels automatically, too.) Or if you do Selenium testing, you might add browser names as labels to indicate which slave has which browser available.

With such set up, you then specify that such and such jobs can be only run on such and such labels. For example, you might say your “test-foo” job requires the “windows” label, while your “compile-bar” job might require the “macos” label.
<!--break-->
Starting 1.372, Hudson now lets you use boolean expressions here, instead of just specifying one label as the requirement. For example, your “seleniumTest-zot” job can now say it requires “windows&&firefox” since it’s meant to run on Windows with Firefox. Or if your job requires a shell script, you might say “!windows” to indicate that it has to be run somewhere that’s not Windows.

Labels are also often used in the context of the multi-configuration project (a.k.a. matrix project.) In a multi-configuration project, you specify what to execute to build your project, then specify a number of “axes” that represents the variable and their possible values to execute a build. There are several different kinds of axes (and this is of course extensible), and one of them is the label axis.

For example, say you have a test suite that you want to run on Windows, Linux, and Solaris, to make sure it works correctly under all these environments. In such a case, you define one label axis, and tell Hudson that you have three possible values “windows”, “linux”, and “solaris.” When you build this project, Hudson will run your build three times by finding appropriate slave that carries the specified label.

In 1.373, you can now specify multiple label axes. For example, you might have a C++ project that needs to be compiled on various platforms. In such a case, you can define one label axis to be “windows”, “linux”, “solaris”, and you can define another label axis to be “32bit” and “64bit”. This will generate 3x2=6 combinations to be executed.

Sometimes the exhaustive combinations do not make sense. In such a case, you can use a filter boolean expression to eliminate some values. You can also use the same mechanism to create a sparse matrix --- that is, you tell Hudson to reduce the coverage to 33%, and Hudson will eliminate every 2 out of 3 combinations.

Finally, I’d like to thank <a href="https://www.sandia.gov/">Sandia National Laboratories</a> for sponsoring this work, which made it possible for <a href="https://infradna.com">InfraDNA</a> to provide this feature to the community. People often think that contributing code is the only way to give back to the project, but sponsoring features like this is another great way to do it.
