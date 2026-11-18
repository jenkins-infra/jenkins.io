require 'awestruct/page'

class ChangelogReleases

  def initialize(release_line, changelog_path, limit_version_key)
    @release_line = release_line
    @changelog_path = changelog_path
    @limit_version_key = limit_version_key # to compare versions, what's the latest released
  end

  def execute(site)
    changelog_entries = site.changelogs ? site.changelogs[@release_line] : nil
    unless changelog_entries
      puts "WARNING: site.changelogs[#{@release_line.inspect}] is not set; skipping changelog release page generation"
      return
    end

    raw_limit_version = site.jenkins ? site.jenkins[@limit_version_key] : nil
    unless raw_limit_version
      puts "WARNING: site.jenkins[#{@limit_version_key.inspect}] is not set; skipping changelog release page generation for #{@release_line}"
      return
    end

    limit_version = Gem::Version.new(raw_limit_version)

    entry_template = Pathname.new(::Awestruct::Engine.instance.site.config.dir).join('_layouts/changelog_entry.html.haml')

    changelog_entries.each do |changelog_entry|
      if Gem::Version.new(changelog_entry.version) <= limit_version
        page = site.engine.load_page(entry_template)
        page.output_path = "/#{@changelog_path}/#{changelog_entry.version}/index.html"
        page.release = changelog_entry
        page.type = @limit_version_key
        page.title = page.title + " for " + changelog_entry.version
        page.backlink = {
          label: "Back to changelog",
          url: @limit_version_key === "stable" ? "/changelog-stable/" : "/changelog/"
        }
        page.uneditable = true
        site.pages << page
      end
    end
  end
end
