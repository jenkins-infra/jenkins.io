---
:layout: post
:title: 'The beginning of a new era: Ruby plugins now a reality'
:nodeid: 353
:created: 1321369200
:tags:
- general
- core
- plugins
- jruby
:author: rtyler
---
<img src="https://web.archive.org/web/*/https://agentdero.cachefly.net/continuousblog/jruby.png" align="right" width="180" alt="Yay JRuby!"/> It's not often that I get to use *that* much hyperbole in a Jenkins blog post, but I think in this case it's allowable. A journey that started over a year ago by [Charles Lowell](https://twitter.com/cowboyd) has reached a new level, thanks to lots of help from [Kohsuke](https://twitter.com/kohsukekawa) along with [Hiroshi Nakamura](https://twitter.com/nahi) and [J&oslash;rgen Tjern&oslash;](https://twitter.com/jorgenpt).

As of today, with Jenkins 1.438, you can now **download and install Ruby plugins from the update center** (the [Path Ignore plugin](https://wiki.jenkins-ci.org/display/JENKINS/Pathignore+Plugin) being the first). 

Words simply can't express what a monumental achievement this is for the Jenkins project, both from the technical perspective but also in terms of what this means for the future of the project.

According to the [languages dashboard on GitHub](https://github.com/languages), Ruby is over two times as popular as Java on the site. I do not intend to start a language popularity contest here, but if we pretend just for a minute that the GitHub ecosystem is all that exists. Can you then imagine how powerful it would be to engage and include a community of open source developers that would be two times the size of the current pool of contributors? That's **tremendous** potential!


### Great! Where do I start?


For those that are curious, the first officially released Ruby plugin for Jenkins is J&oslash;rgen's [pathignore-plugin](https://github.com/jenkinsci/pathignore-plugin) which can be found in the update center. If you're looking for a reference project, this is currently the most up-to-date plugin.

There is also a **[wiki page covering Ruby plugin development](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+plugin+development+in+Ruby)**, which might be a little out-of-date but covers most of the essentials.

Additionally you might find the [jenkins-prototype-plugin](https://github.com/cowboyd/jenkins-prototype-ruby-plugin) an interesting resource as it is practically a kitchen sink of demo/test Ruby plugin code.

Currently only a few extension points (BuildStep, Publisher, BuildWrapper) are mapped in a Ruby-friendly manner. Don't let that scare you though! If you dig around in the [jenkins-plugin-runtime](https://github.com/cowboyd/jenkins-plugin-runtime) you can see how the existing extension points are mapped from Java into Ruby, because Ruby plugins are running under JRuby, if you need to access some Java APIs, you can do so without too much trouble.

### The Thank Yous

Great efforts like this one don't just happen without support, which is why I'd like to call out and thank [The FrontSide](https://thefrontside.net/) for their **wonderful** support, helping to cover costs of WebEx for Office Hours and covering Charles' time while he worked with Kohsuke on the internal plumbing needed to make Ruby plugins possible within Jenkins core. If the name "The FrontSide" looks familiar to you, that might be because they also created and donated the Jenkins logo!

We should also thank [Lookout, Inc](https://www.mylookout.com) (*full disclosure: Lookout is my employer*) and [CloudBees](https://www.cloudbees.com) for affording some employee time for J&oslash;rgen and Kohsuke respectively to work on the project.


<!--break-->
