require 'yearposts'

Awestruct::Extensions::Pipeline.new do
  extension YearPosts.new('/blog', :posts)
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Sitemap.new
  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/rss.xml',
                                                :feed_title => 'Jenkins Blog')
end

