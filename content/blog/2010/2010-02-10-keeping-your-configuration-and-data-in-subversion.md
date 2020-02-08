---
:layout: post
:title: Keeping your configuration and data in Subversion
:nodeid: 148
:created: 1265810400
:tags:
- development
- guest post
- jobs
- just for fun
- tutorial
:author: rtyler
---
We all know that keeping important files in version control is critical, as it ensures problematic changes can be reverted and can serve as a backup mechanism as well. Code and resources are often kept in version control, but it can be easy to forget your continuous integration (CI) server itself! If a disk were to die or fall victim to a [misplaced](https://twitter.com/progrium/status/7646048501) `rm -rf`, you could lose all the history and configuration associated with the jobs your CI server manages.

It’s pretty simple to create a repository, but it isn’t obvious which parts of your $HUDSON_HOME you’ll want to backup. You’ll also want to have some automation so new projects get added to the repository, and deleted ones get removed. Luckily we have a great tool to handle this: Hudson!

We have a Hudson job which runs nightly, performs the appropriate SVN commands, and checks in. The high-level overview of this job is basically:

1.  Add any new jobs, users, plugin configurations, et cetera: `svn add -q --parents *.xml jobs/*/config.xml users/*/config.xml userContent/*`
1.  Remove anything from SVN that no longer exists (such as a deleted job): `svn status | grep '!' | awk '{print $2;}' | xargs -r svn rm`
1.  Check it in! `svn ci --non-interactive --username=mrhudson -m "automated commit of Hudson configuration"`
You’ll want to make sure to use the `--non-interactive` option for any automated svn operations, as this ensures Subversion won’t hang asking a question but instead fail immediately. You may also need to provide your password with the `--password` option.

To make such a Hudson job, create a new job, tie it to the master (since this is where the configuration files are), set it to build periodically (we use “@midnight”), and add an “Execute shell” build step. Here’s the full script we use, to put into the build step:

<code type="bash">
# Change into your HUDSON_HOME.
cd /opt/hudson
# Add any new conf files, jobs, users, and content.
svn add -q --parents *.xml jobs/*/config.xml users/*/config.xml userContent/*
# Ignore things in the root we don't care about.
echo -e "warnlogn*.logn*.tmpn*.oldn*.bakn*.jarn*.json" > myignores
svn propset svn:ignore -F myignores . && rm myignores
# Ignore things in jobs/* we don't care about.
echo -e "buildsnlast*nnext*n*.txtn*.lognworkspace*ncoberturanjavadocnhtmlreportsnncoverndoclinks" > myignores
svn propset svn:ignore -F myignores jobs/* && rm myignores
# Remove anything from SVN that no longer exists in Hudson.
svn status | grep '!' | awk '{print $2;}' | xargs -r svn rm
# And finally, check in of course, showing status before and after for logging.
svn st && svn ci --non-interactive --username=mrhudson -m "automated commit of Hudson configuration" && svn st
</code>

You’ll notice this does some extra things like set the svn:ignores property to provide a relatively clean `svn st` which it shows before and after the commit for logging purposes. One thing this job *doesn’t* do is put the build results of your jobs in version control. Because historical build logs and artifacts will never change and are also potentially large, a periodic (daily or weekly) `cp` or `rsync` of the **jobs** directory will still give you restorability while keeping your repository lean.

Now you can sleep well at night knowing that your CI server is safe and sound. If you are doing a similar thing with Hudson or another CI system, let us know about your solution!

----
**Editor's Note:** <a id="aptureLink_S8IC1qB8oH" href="https://twitter.com/MikeRooney">Mike Rooney</a> is a Software Engineer at <a id="aptureLink_tuyi7spa9e" href="https://twitter.com/Genius_com">Genius.com</a>, provider of real-time marketing automation software connecting marketing and sales. You can read more posts from Mike and other Geniuses at [eng.genius.com](https://eng.genius.com)

