require 'awestruct/extensions/data_dir'
require 'awestruct/extensions/partial'
require 'asciidoctor/jenkins/extensions'

Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |extension|
  next if extension == __FILE__
  require extension
end

Awestruct::Extensions::Pipeline.new do
  # Register all our blog content under the `site.posts` variable
  extension YearPosts.new('/blog', :posts)
  extension Awestruct::Extensions::Indexifier.new

  extension Awestruct::Extensions::Paginator.new(:posts,
                                                  '/blog/index',
                                                  :per_page => 9)

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
                                              '/blog/index',
                                              '/blog/tags',
                                              :per_page => 9)

  extension JenkinsSitemap.new

  extension Awestruct::Extensions::DataDir.new

  extension SolutionPage.new
  extension WellKnown.new
  extension Releases.new

  extension UpgradeGuide.new
  extension SecurityIssues.new

  extension AuthorList.new(:posts,
                        '/blog/index',
                        :per_page => 9)

  extension Awestruct::IBeams::HandbookExtension.new(:handbook,
                                                     File.expand_path(File.dirname(__FILE__) + '/../doc/book'))

  extension Awestruct::IBeams::HandbookExtension.new(:devbook,
                                                     File.expand_path(File.dirname(__FILE__) + '/../doc/developer'))

  extension ChangelogReleases.new(:lts, 'changelog-stable', 'stable')
  extension ChangelogReleases.new(:weekly, 'changelog', 'latest')

  transformer VersionSwitcher.new

  extension Validator.new

  helper AuthorList::AuthorLink
  helper ActiveNav
  helper IdGenerator
  helper Authorship
  helper Legacy
  helper AsciidocRender
  helper GetPlugins

  helper Awestruct::Extensions::GoogleAnalytics
  helper AsciidocSections
  helper Awestruct::Extensions::Partial
end
