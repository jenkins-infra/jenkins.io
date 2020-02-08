---
:layout: post
:title: 'Getting started: Building Android apps with Hudson'
:nodeid: 200
:created: 1266414300
:tags:
- general
- guest post
- jobs
- tutorial
:author: rtyler
---
In this post I'll show a very basic tips on how to compile an Android project using Hudson. Specifically how  I use Hudson to create release versions of my apps.

Debug vs Release
----------------
I'm assuming that you are using <a id="aptureLink_s44SkgAX9H" href="https://en.wikipedia.org/wiki/Eclipse%20%28software%29">Eclipse</a> with the <a id="aptureLink_MtfIHO5Nxu" href="https://developer.android.com/guide/developing/tools/adt.html">ADT plugin</a>. During development you can test your app on the emulator or a device and resources like R.java and aidl files are compiled for you automatically by the plugin. When it's time to release your app, you'll need to go through some steps:

* You must sign your app using a certificate
* You must update your AndroidManifest.xml to remove the android:debuggable attribute
* Replace your Google Maps API debug key with the one belonging to your release certificate (if you are using a MapView)
* Generate an apk package for the release and test it on a device or emulator

It would be nice to automate a few of these steps, and this is where Hudson comes in.

Automated builds: Ant
---------------------
For automated builds the Android SDK uses <a id="aptureLink_THdW39aNW6" href="https://en.wikipedia.org/wiki/Apache%20Ant">Apache Ant</a>, which Hudson has great support for. To generate a template build.xml you can use the android tool from the SDK using the following command:
<code linenumbers=off>
android create project -n template -t android-7 -p template -k dummy.pkg -a Dummy
</code>
The target is specified as "android-7" meaning that we are building for Android 2.1. For apps that use MapView we would use "Google Inc.:Google APIs:7". It is a good idea to always [target the latest SDK](https://d.android.com/guide/practices/screens_support.html#strategies). From this template project we'll grab the *build.properties* and the *build.xml* and copy those to the Android project that we want to build. Edit *build.xml* and set the project name to your Android project name. 

The *local.properties* file contains the path to the SDK root and shouldn't be checked in to version control. For our use we'll set the properties that are in that file on the Hudson job configuration page.

## Running the build in Hudson
This part is easy: create a new freestyle job and let it be build with ant. The targets that we want to execute are <code>clean release</code>. Release will compile, package and sign your apk. Now to get this working right, some custom properties should be set (use the Advanced button).

```
sdk.dir=/Users/hugo/Code/android-sdk-mac
target=Google Inc.:Google APIs:7
key.store=certs/rd-release.keystore
key.alias=rainydays
key.store.password=thisisnotmypassword
key.alias.password=thisisnotmypassword
```

The *sdk.dir* should point to the Android SDK root on your Hudson node. In my case I'm running Hudson locally on my machine.  The *target* property refers to the SDK we want to use as mentioned earlier.  The *key.** properties are related to signing of the apk. My [strategy](https://d.android.com/guide/publishing/app-signing.html#strategies) is to have a separate key store and private key for each application that I develop. I also check that keystore in to SVN. I also archive the **-release.apk* artifact so that I can download the latest release apk directly from Hudson.  After completing these steps, you should be able to build your Android app with Hudson. 

<br clear="all"/>
## Updating the AndroidManifest for release
...But we're not done yet :) Remember what I said about updating the AndroidManifest.xml? For that we need to edit the build.xml, which by default contains nothing more then a <code><setup/></code> tag to pull in the Android SDK ant target definitions. For my Rainy Days application, I adjusted build.xml like this:

```
   ...
   <setup />	
   <property environment="env"/>
   <target name="preprocess" if="env.BUILD_TAG">
      <echo>Removing debug attribute from AndroidManifest.xml</echo>
      <replaceregexp file="AndroidManifest.xml" match="android:debuggable=&quot;.*?&quot;" replace=""/>
      <echo>Setting release maps key</echo>
      <replaceregexp file="res/layout/maplayout.xml" match="android:apiKey=&quot;.*?&quot;" replace="android:apiKey=&quot;XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&quot;"/>			
   </target>
	
   <!-- this target is only hooking release processing of the manifest -->
   <target name="-package-resources" depends="preprocess, android_rules.-package-resources">
   </target>
```

What the above snippet does is removing the *android:debuggable* attribute from the *AndroidManifest.xml* and replacing the maps API key in *res/layout/maplayout.xml* with the correct key for release. The <code>-package-resources</code> target is pulled in from the Android *android_rules.xml* file.

Now when Hudson builds my app I get a ready to release apk that I can install on my device or emulator, which is pretty nice.

There is are some issues with this approach however. As you might have noticed:

* Replacements are done in the workspace, we are not really building __exactly__ what's in svn
* Each new build should start out fresh for that reason, for example by using the svn revert option.

Additionally I can not yet tag the release version with the updated files, because the [subversion tagging plugin](https://plugins.jenkins.io/subversion-tagging) doesn't support this by design. This could be worked around by adding svn statements in the build.xml however.  For now I don't really mind as I make minor changes to the resource files, but I'll be looking at improving this situation.

## Things to add: unit testing, coverage...
One thing that I'd really like to add is unit testing. This is a little bit more complicated though, since unit tests require a running emulator and a running emulator requires a gui. The Hudson [Xvnc](https://plugins.jenkins.io/xvnc) plugin could be very helpful here.

The Android build scripts for test projects already include [EMMA](http://emma.sourceforge.net/) output, it shouldn't be to hard to use the Hudson [plugin](https://plugins.jenkins.io/emma) for that.

When Hudson is running on a local machine, the [Batch task](https://plugins.jenkins.io/batch-task) plugin can automate installing the apk on a device to automate things further.

## Summary
Building Android applications with Hudson is not that hard, since the builds are based on Ant. By hooking in to the standard Android build targets it's easy to update files like *AndroidManifest.xml* which in turn makes sure the release process is controlled and predictable.  
Android unit tests depend on the emulator which is a little bit more challenging to set up, but Hudson already has some plugins available to make this easier.

----
**Editor's Note:** Hugo Visser is the developer of [Rainy Days](https://code.neenbedankt.com/my-first-published-android-app-rainy-days) and [Engine Watch](https://code.neenbedankt.com/monitor-your-app-engine-application-from-your-pocket-with-engine-watch-for-android/) for Android. You can
follow him [on Twitter](https://twitter.com/botteaap) and [on his blog](https://code.neenbedankt.com).
<!--break-->
