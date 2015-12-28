# This extension will help deal with generating the site with two different
# versions of the "default" template. This is to allow us to generate the
# legacy and jenkins.io sites side-by-side without needing to convert expects that some files are in the _tmp directory so it can
# add their content to the site object

require 'legacy'

class VersionSwitcher
  include Legacy

  def transform(site, page, rendered)
    if legacy? && page.legacy == false
      puts page.inspect
      return '<html><head><meta http-equiv="refresh" content="0;/"/>'
    end
    return rendered
  end
end
