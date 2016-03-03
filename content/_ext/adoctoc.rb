require 'asciidoctor'


# The DirectoryTOC module helps provide the ability to generate a nested
# datastructure based on the asciidoc files inserted into a directory. Instead
# of requiring the user to create one large monolithic `.adoc` file, this
# allows individual sections to be defined and managed as separate files
module DirectoryTOC
  def compute_section_link(document, title)
    prefix = document.attributes['idprefix'] || ''
    separator = document.attributes['idseparator'] || '-'
    title = title.downcase.gsub(Asciidoctor::InvalidSectionIdCharsRx, separator)

    return [
      prefix,
      title.tr_s(separator, separator).chomp(separator),
    ].join('')
  end

  def find_all_sections(section, document)
    children = []
    section.sections.each do |sub|
      children << [sub.title,
                   document.file,
                   compute_section_link(document, sub.title),
                   find_all_sections(sub, document)]
    end
    return children
  end

  def adoc_toc_for(directory, awestruct_pages)
    pages_by_path = awestruct_pages.map { |p| [p.source_path, p] }.to_h
    toc = []

    Dir[File.join(directory, '*.adoc')].each do |adoc|
      page = pages_by_path[adoc]
      # Since all our documents are going to have front-matter so they render
      # properly, we need to look first at the Awestruct::Page and then
      # re-render to grab the sections from the asciidoc
      document = Asciidoctor.load(page.raw_content)

      document.sections.each do |section|
        children = find_all_sections(section, document)
        toc << [section.title, adoc, page.url, children]
      end
    end
    return toc
  end
end
