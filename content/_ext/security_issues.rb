require 'awestruct/page'

class SecurityIssues
  def execute(site)
    advisories = site.pages.select { |p| p.source_path =~ /security\/advisory\// }

    template = Pathname.new(::Awestruct::Engine.instance.site.config.dir).join('_ext/security_issue.html.haml')

    all_issues = Array.new

    advisories.each do |advisory|
      advisory_yaml = YAML.load(File.read(advisory.source_path))
      if advisory_yaml['issues']
        advisory_yaml['issues'].each do |issue|
          advisory_entry = issue['id']

          if advisory_entry =~ / \([2-9]\)/
            # If one issue has two advisory entries, skip duplicate pages and ensure we link to the first entry
            next
          end

          issue_id = advisory_entry.gsub(/ .*/, '')
          numeric_id = issue_id.gsub(/SECURITY-/, '')

          all_issues << { :id => numeric_id.to_i, :redirect_id => issue_id }

          page = site.engine.load_page(template)
          page.output_path = "/security/issue/#{issue_id}/index.html"
          page.redirect_url = advisory.output_path + "##{advisory_entry}"
          site.pages << page
        end
      end
    end

    site.send('security_issues=', all_issues)
  end
end
