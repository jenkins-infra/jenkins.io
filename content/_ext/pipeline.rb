require 'debuggable-partial'
require 'legacy'
require 'releases'
require 'versionswitcher'
require 'yearposts'

Awestruct::Extensions::Pipeline.new do
  # Register all our blog content under the `site.posts` variable
  extension YearPosts.new('/blog', :posts)

  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Sitemap.new
  extension Awestruct::Extensions::DataDir.new

  #extension Awestruct::Extensions::Tagger.new(:posts,
  #                                             '/blog')

  extension Awestruct::Extensions::Paginator.new(:posts,
                                                  '/node/index',
                                                  :per_page=> 8)

  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/rss.xml',
                                                :feed_title => 'Jenkins Blog')

  extension Awestruct::Extensions::Sitemap.new

  extension Releases.new

  transformer VersionSwitcher.new

  helper DebuggablePartial
  helper Legacy
  helper Awestruct::Extensions::GoogleAnalytics
end

