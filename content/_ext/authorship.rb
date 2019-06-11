# The authorship helper helps display authorship for a given entity
#
# This only renders something if the author has put information in
# content/_data/authors and the document has an `author` attribute in its
# front-matter
require 'authorlist.rb'
module Authorship
  include AuthorList::AuthorLink

  def display_author_for(node)
    # bail early if what we were given doesn't even respond
    return unless node.author
    display_user(node.author)
  end

  def display_user(author)
    if site.authors.has_key? author.to_sym
      full_name = site.authors[author].name
    else
      raise "File with personal information (content/_data/authors/#{author}.adoc) is missing"
    end

    link = author_link(author)

    return "<a href=\"#{link}\">#{full_name}</a>"
  end
end
