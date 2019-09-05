---
name: "New blogpost"
labels: blogpost
about: Create a new blogpost
assignees: @jenkins-infra/copy-editors
---

<!--
See https://github.com/jenkins-infra/jenkins.io/blob/master/CONTRIBUTING.adoc#adding-a-blog-post for the detailed guidelines
-->

### Description

Please describe your issue here.

### Your checklist for this issue

- [ ] The blogpost is written in Asciidoc
- [ ] The author field is referencing an existing author profile (you can create one [here](https://github.com/jenkins-infra/jenkins.io/tree/master/content/_data/authors)) 
- [ ] If you refer a local content on jenkins.io, relative links are used
- [ ] If you want to have a custom image for social media, a custom `opengraph` field is added
- [ ] If you add new images to the blogposts, these ipages should be stored in a folder under `/images/post-images/${YOUR_BLOGPOST_FOLDER}` where the new folder somehow summarizes the blog in few words. 
      it is not adviced to add dates to the folder names, because they may change easiily

<!-- TODO: there is no documentation for authors and opengraph -->

### Copy-editor checklist

- [ ] CI is passing on ci.jenkins.io
- [ ] Before merge: The blogpost date is updated to represent the publishing date

<!--
Put an `x` into the [ ] to show you have filled the information below
Describe your issue below
-->

