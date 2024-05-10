require 'awestruct/page'

class UpgradeGuide
  def execute(site)
    prefix = "/doc/upgrade-guide"
    stable = Gem::Version.new(site.jenkins.stable)
    versions = site.upgrades.keys.select {|x| Gem::Version.new(x.to_s.tr_s("-",".")) <= stable}
    grouped = versions.group_by {|x| x.to_s.split('-')[0..1].join('.')}
    grouped = grouped.sort {|x, y| -(Gem::Version.new(x[0]) <=> Gem::Version.new(y[0]))}.to_h
    grouped.each do |major, minor_versions|
      minor_versions.sort!.reverse!
      page = site.engine.find_and_load_site_page( "#{prefix}" )
      page.output_path = File.join( prefix, "#{major}/index.html" )
      page.version = major.to_s
      site.pages << page
    end
    site.send("versions_grouped=", grouped)
  end
end

