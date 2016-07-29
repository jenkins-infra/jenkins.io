require 'asciidoctor'
require 'yaml'

module Awestruct
  module IBeams

    class Section
      attr_accessor :title, :file, :asciidoc, :key
    end

    class Chapter
      attr_accessor :number, :sections, :title,
                    :file, :asciidoc, :key

      def initialize
        @sections = []
      end
    end

    class Handbook
      attr_accessor :book_dir, :chapters

      def initialize(book_dir)
        @book_dir = book_dir
        @chapters = {}
      end

      def chapter_for_path(path)
        if @chapters_map.nil?
          @chapters_map = @chapters.values.map { |c| [c.key, c] }.to_h
        end

        return @chapters_map[path]
      end
    end

    class HandbookExtension
      def initialize(book_dir)
        @book_dir = book_dir
      end

      def execute(site)
        unless site.handbook
          site.handbook = Handbook.new(@book_dir)
        end
        # We need a map of source files to their Awestruct::Page to avoid
        # re-rendering things too much in the process of generating this page
        pagemap = site.pages.map { |p| [p.source_path, p] }.to_h
        chapters = Dir[File.join(@book_dir, "/**/chapter.yml")]

        chapters.map { |c| [c, YAML.load(File.read(c))] }.each do |file, yaml|
          dir = File.dirname(file)
          overview = File.join(dir, 'index.adoc')
          # Without an overview page, there's no point in attempting to add
          # this to the structure
          next unless File.exists? overview

          chapter = Chapter.new
          chapter.number = yaml['chapter']
          chapter.title = pagemap[overview].title
          chapter.key = File.basename(dir)

          if sections = yaml['sections']
            sections.each do |s|
              section = Section.new
              section.key = s
              full_path = File.join(dir, "#{s}.adoc")
              section.title = pagemap[full_path].title
              chapter.sections << section
            end
          end

          site.handbook.chapters[chapter.number] = chapter
        end
      end
    end
  end
end
