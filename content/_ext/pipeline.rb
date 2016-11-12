require 'awestruct/ibeams/debuggable_partial'
require 'awestruct/ibeams/asciidoc_sections'
require 'awestruct/ibeams/datadir'

Dir[File.join(File.dirname(__FILE__), '*.rb')].each do |extension|
  next if extension == __FILE__
  require extension
end

begin
  require 'tilt/asciidoc'
  Haml::Filters.register_tilt_filter 'AsciiDoc'
  Haml::Filters::AsciiDoc.options[:safe] = :safe
  Haml::Filters::AsciiDoc.options[:attributes] ||= {}
  Haml::Filters::AsciiDoc.options[:attributes]['notitle!'] = ''
rescue Exception => e
  # Catch exceptions which will be raised when we reload this file in an
  # awestruct development environment, see:
  # <https://github.com/haml/haml/blob/master/lib/haml/filters.rb#L39>
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
                                                :template => '_ext/atom.xml.haml')

  extension Awestruct::Extensions::Tagger.new(:posts,
                                              '/node/index',
                                              '/node/tags',
                                              :per_page => 10)

  extension Awestruct::Extensions::Sitemap.new

  extension Awestruct::IBeams::DataDir.new

  extension SolutionPage.new
  extension Releases.new

  extension Awestruct::IBeams::HandbookExtension.new(File.expand_path(File.dirname(__FILE__) + '/../doc/book'))

  transformer VersionSwitcher.new

  helper ActiveNav
  helper Authorship
  helper Legacy

  helper Awestruct::Extensions::GoogleAnalytics
  helper Awestruct::IBeams::AsciidocSections
  helper Awestruct::IBeams::DebuggablePartial
end
