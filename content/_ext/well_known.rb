require 'awestruct/page'

# Workaround for . prefixed directories being ignored
class WellKnown
  def execute(site)
    # TODO Make more generic, iterate over all files in the directory
    page = site.engine.load_page("#{site.dir}/.well-known/security.txt")
    page.output_path = "/.well-known/security.txt"
    site.pages << page
  end
end
