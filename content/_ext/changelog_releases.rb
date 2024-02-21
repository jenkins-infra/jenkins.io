require 'awestruct/page'

class ChangelogReleases

  def initialize(release_line, changelog_path, limit_version_key)
    @release_line = release_line
    @changelog_path = changelog_path
    @limit_version_key = limit_version_key # to compare versions, what's the latest released
  end

  def execute(site)
    changelog_entries = site.changelogs[@release_line]

    entry_template = Pathname.new(::Awestruct::Engine.instance.site.config.dir).join('_layouts/changelog_entry.html.haml')

    changelog_entries.each do |changelog_entry|
      page = site.engine.load_page(entry_template)
      page.output_path = "/#{@changelog_path}/#{changelog_entry.version}/index.html"
      page.release = changelog_entry
      site.pages << page
    end
  end
end
