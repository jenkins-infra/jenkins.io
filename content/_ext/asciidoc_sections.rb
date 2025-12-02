require 'asciidoctor'
require 'naturally'

module AsciidocSections
  module Errors
    class InvalidPath < Exception; end;
  end

  # sections_from() will take the given
  #
  # @param [String] relative or absolute path to a directory containing
  #   asciidoc files (`.ad`, `.adoc`)
  # @return [Array] Array of arrays containing: [section_title, filepath,
  #   link_to_section, subsections]
  # @raise [Errors::InvalidPath] thrown when the provided +directory+ is
  #   not a valid path to an existing directory
  def sections_from(directory)
    if directory.nil?
      raise Errors::InvalidPath.new("The provided `directory` was nil")
    end
    unless File.directory?(directory)
      raise Errors::InvalidPath.new("The provided `#{directory}` is not a valid directory")
    end

    # Generate a +Hash+ of all the pages in the site keyed by their path
    # for easy discovery
    pages_by_path = site.pages.map { |p| [p.source_path, p] }.to_h
    sections = []

    Naturally.sort(Dir.glob(File.join(directory, '*.{ad,adoc}'))).each do |adoc|
      # Since all our documents are going to have front-matter so they render
      # properly, we need to look first at the Awestruct::Page and then
      # re-render to grab the sections from the asciidoc
      page = pages_by_path[adoc]
      url = page.url
      document = Asciidoctor.load(page.raw_content)

      document.sections.each do |section|
        sections << [
          section.title,
          {
            :asciidoc => document,
            :path => adoc,
            :page => page,
          },
          url,
          find_subsections_from(section, document)
        ]
      end
    end

    return sections
  end


  # This method will recurse through all the subsections of the given
  # +section+ to discover the full tree of subsections and compute a nested
  # array containing them.
  #
  # @param [Asciidoctor::Section] section to discover subsections from
  # @param [Asciidoctor::Document] Document objection the section anchor
  #   belongs to, this is necessary to ensure the document's settings are
  #   used to provide the appropriate anchors
  # @return [Array] of subsection arrays
  def find_subsections_from(section, in_document)
    found = []

    section.sections.each do |subsection|
      title = subsection.title
      found << [
        title,
        {
          :asciidoc => in_document,
          :path => in_document.file,
        },
        section_anchor(title, in_document),
        find_subsections_from(subsection, in_document),
      ]
    end

    return found
  end


  # Compute an appropriate section anchor for the given title within the
  # given +Asciidoctor::Document+. This is effectively the same logic that
  # Asciidoctor itself inside the +Asciidoctor::Section#generate_id+ method
  # but extracted to be callable in an idempotent fashion
  #
  # @param [String] title of the section provided
  # @param [Asciidoctor::Document] Document object the section anchor
  #   belongs to, this is necessary to ensure the document's settings are
  #   used to provide the appropriate anchor
  # @return [String] Computed section anchor
  def section_anchor(title, in_document)
    prefix = in_document.attributes['idprefix'] || ''
    separator = in_document.attributes['idseparator'] || '-'
    title = title.downcase.gsub(Asciidoctor::InvalidSectionIdCharsRx, '')

    return [
      prefix,
      title.tr_s(" ._-", separator).chomp(separator).delete_prefix(separator),
    ].join('')
  end
end
