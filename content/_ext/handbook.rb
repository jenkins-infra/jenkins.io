require 'asciidoctor'
require 'yaml'

module Awestruct
  module IBeams

    class Section
      attr_accessor :title, :file, :asciidoc, :key, :summary, :page, :subsections

      def initialize
        @subsections = []
      end
    end

    class Chapter
      # TODO replace half of these with usages of :page
      attr_accessor :sections, :guides, :title,
                    :file, :asciidoc, :key, :summary, :page

      def initialize
        @sections = []
        @guides = []
      end
    end

    class Guide
      attr_accessor :file, :key, :chapter, :page
    end

    class Subsection
      attr_accessor :title, :file, :key, :page, :summary, :chapter
    end

    class Handbook
      attr_accessor :book_dir, :chapters, :guides, :subsections

      def initialize(book_dir)
        @book_dir = book_dir
        @chapters = []
        @guides = []
      end

    end

    class HandbookExtension
      attr_accessor :name

      def initialize(name, book_dir)
        @name = name
        @book_dir = book_dir
      end

      def execute(site)
        site[@name] = Handbook.new(@book_dir)
        # We need a map of source files to their Awestruct::Page to avoid
        # re-rendering things too much in the process of generating this page
        pagemap = site.pages.map { |p| [p.source_path, p] }.to_h

        book_file = File.join(@book_dir, "_book.yml")

        book_yaml = YAML.load(File.read(book_file))

        chapters = book_yaml['chapters']

        chapters.each do |c|
          dir = File.join(@book_dir, c)
          file = File.join(dir, '_chapter.yml')
          overview = File.join(dir, 'index.adoc')

          # Without an chapter file and overview page, there's no point in attempting to add
          # this to the structure
          next unless File.exist? file
          next unless File.exist? overview

          yaml = YAML.load(File.read(file))

          chapter = Chapter.new
          chapter.key = c
          chapter.page = pagemap[overview]
          chapter.title = pagemap[overview].title
          chapter.summary = pagemap[overview].summary

          if sections = yaml['sections']
            sections.each do |s|
              section = Section.new
              section.key = s
              begin
                full_section_path = File.join(dir, "#{s}.adoc")
                unless File.exist?(full_section_path)
                  raise "Could not find section file #{s}.adoc in #{dir}."
                end
                section.page = pagemap[full_section_path]
                section.title = pagemap[full_section_path].title
                section.summary = pagemap[full_section_path].summary
                chapter.sections << section
              rescue
                full_section_path = File.join(dir, "#{s}", "index.adoc")
                unless File.exist?(full_section_path)
                  raise "Could not find subsection file #{s}/index.adoc in #{dir}."
                end
                section.page = pagemap[full_section_path]
                section.title = pagemap[full_section_path].title
                section.summary = pagemap[full_section_path].summary
                chapter.sections << section
              end
            end
          end

          if sections = yaml['sections']
            sections.each do |s|
              chapter.sections.each do |section|
                if s == section.key
                  subsection_file = File.join(dir, "#{s}", "_section.yml")
                  if File.exist?(subsection_file)
                    subsection_yaml = YAML.load(File.read(subsection_file))
                    if subsections = subsection_yaml['subsections']
                      subsections.each do |ss|
                        subsection = Subsection.new
                        subsection.key = ss
                        full_subsection_path = File.join(dir, "#{s}", "#{ss}.adoc")
                        subsection.page = pagemap[full_subsection_path]
                        subsection.title = pagemap[full_subsection_path].title
                        subsection.summary = pagemap[full_subsection_path].summary
                        subsection.chapter = chapter
                        section.subsections << subsection
                      end
                    end
                  end
                end
              end
            end
          end

          if guides = yaml['guides']
            guides.each do |g|
              guide = Guide.new
              guide.key = g
              full_guide_path = File.join(dir, "#{g}.adoc")
              unless File.exist?(full_guide_path)
                raise "Could not find guide file #{g}.adoc in #{dir}."
              end
              guide.page = pagemap[full_guide_path]
              chapter.guides << guide
              guide.chapter = chapter
              site[@name].guides << guide
            end
          end

          site[@name].chapters << chapter
        end
      end
    end
  end
end
