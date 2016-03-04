

Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |extension|
  next if extension == __FILE__
  require extension
end

Awestruct::Extensions::Pipeline.new do
  # Register all our blog content under the `site.posts` variable
  extension YearPosts.new('/blog', :posts)
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Sitemap.new
  extension Awestruct::Extensions::DataDir.new
  extension Awestruct::Extensions::Paginator.new(:posts,
                                                  '/node/index',
                                                  :per_page=> 8)

  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/rss.xml',
                                                :feed_title => 'Jenkins Blog',
                                                :template => '_ext/atom.xml.haml')

  extension Awestruct::Extensions::Sitemap.new
  extension SolutionPage.new
  extension Releases.new

  transformer VersionSwitcher.new

  helper DebuggablePartial
  helper Authorship
  helper Legacy
  helper DirectoryTOC
  helper Awestruct::Extensions::GoogleAnalytics
end

