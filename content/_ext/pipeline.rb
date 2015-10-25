require 'yearposts'

Awestruct::Extensions::Pipeline.new do
  extension YearPosts.new('/blog', :posts)
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Sitemap.new
  extension Awestruct::Extensions::DataDir.new

  #extension Awestruct::Extensions::Tagger.new(:posts, 
  #                                             '/blog')

  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/rss.xml',
                                                :feed_title => 'Jenkins Blog')

  helper Awestruct::Extensions::Partial
  helper Awestruct::Extensions::GoogleAnalytics
end

