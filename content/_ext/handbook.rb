require 'asciidoctor'
require 'yaml'

module Awestruct
  module IBeams

    class Section
      attr_accessor :title, :file, :asciidoc, :key
    end

    class Chapter
      attr_accessor :sections, :title,
                    :file, :asciidoc, :key

      def initialize
        @sections = []
      end
    end

    class Handbook
      attr_accessor :book_dir, :chapters

      def initialize(book_dir)
        @book_dir = book_dir
        @chapters = []
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
          chapter.title = pagemap[overview].title

          if sections = yaml['sections']
            sections.each do |s|
              section = Section.new
              section.key = s
              full_path = File.join(dir, "#{s}.adoc")
              section.title = pagemap[full_path].title
              chapter.sections << section
            end
          end

          site[@name].chapters << chapter
        end
      end
    end
  end
end
