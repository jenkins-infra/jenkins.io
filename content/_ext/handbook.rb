require 'asciidoctor'
require 'yaml'

module Awestruct
  module IBeams

    class Section
      attr_accessor :title, :file, :asciidoc, :key, :summary, :page
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

    class Handbook
      attr_accessor :book_dir, :chapters, :guides

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
        unless site[@name]
          site[@name] = Handbook.new(@book_dir)
        end
        # We need a map of source files to their Awestruct::Page to avoid
        # re-rendering things too much in the process of generating this page
        pagemap = site.pages.map { |p| [p.source_path, p] }.to_h
        book_file = File.join(@book_dir, "book.yml")

        book_yaml = YAML.load(File.read(book_file))

        chapters = book_yaml['chapters']

        chapters.each do |c|
          dir = File.join(@book_dir, c)
          file = File.join(dir, 'chapter.yml')
          overview = File.join(dir, 'index.adoc')

          # Without an chapter file and overview page, there's no point in attempting to add
          # this to the structure
          next unless File.exists? file
          next unless File.exists? overview

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
              full_path = File.join(dir, "#{s}.adoc")
              section.page = pagemap[full_path]
              section.title = pagemap[full_path].title
              section.summary = pagemap[full_path].summary
              chapter.sections << section
            end
          end

          if guides = yaml['guides']
            guides.each do |g|
              guide = Guide.new
              guide.key = g
              full_path = File.join(dir, "#{g}.adoc")
              guide.page = pagemap[full_path]
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
