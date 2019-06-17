require 'awestruct/ibeams/debuggable_partial'
require 'awestruct/ibeams/asciidoc_sections'
require 'awestruct/ibeams/datadir'
require 'asciidoctor/jenkins/extensions'

Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |extension|
  next if extension == __FILE__
  require extension
end

Awestruct::Extensions::Pipeline.new do
  # Register all our blog content under the `site.posts` variable
  extension YearPosts.new('/blog', :posts)
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Sitemap.new

  extension Awestruct::Extensions::Paginator.new(:posts,
                                                  '/node/index',
                                                  :per_page=> 8)

  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/rss.xml',
                                                :feed_title => 'Jenkins Blog',
                                                :template => '_ext/atom.xml.haml',
                                                :num_entries => 50)

  extension Awestruct::Extensions::Atomizer.new(:posts,
                                                '/full-rss.xml',
                                                :feed_title => 'Jenkins Blog',
                                                :template => '_ext/atom.xml.haml',
                                                :num_entries => 4096)

  extension Awestruct::Extensions::Tagger.new(:posts,
                                              '/node/index',
                                              '/node/tags',
                                              :per_page => 10)

  extension Awestruct::Extensions::Sitemap.new

  extension Awestruct::IBeams::DataDir.new

  extension SolutionPage.new
  extension Releases.new

  extension UpgradeGuide.new

  extension AuthorList.new(:posts,
                        '/node/index',
                        :per_page => 10)
  extension Awestruct::IBeams::HandbookExtension.new(:handbook,
                                                     File.expand_path(File.dirname(__FILE__) + '/../doc/book'))

  extension Awestruct::IBeams::HandbookExtension.new(:devbook,
                                                     File.expand_path(File.dirname(__FILE__) + '/../doc/developer'))

  transformer VersionSwitcher.new

  helper AuthorList::AuthorLink
  helper ActiveNav
  helper Authorship
  helper Legacy

  helper Awestruct::Extensions::GoogleAnalytics
  helper Awestruct::IBeams::AsciidocSections
  helper Awestruct::IBeams::DebuggablePartial
end
