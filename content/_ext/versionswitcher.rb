# This extension will help deal with generating the site with two different
# versions of the "default" template. This is to allow us to generate the
# legacy and jenkins.io sites side-by-side without needing to convert expects that some files are in the _tmp directory so it can
# add their content to the site object

class VersionSwitcher
  def transform(site, page, rendered)
    return rendered
  end
end
