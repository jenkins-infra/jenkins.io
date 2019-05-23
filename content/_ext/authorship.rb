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

    author = node.author.to_sym
    if node.author && site.authors.has_key?(author)
      full_name = site.authors[author].name
    else
      full_name = author
    end

    link = author_link(author)

    return "<a href=\"#{link}\">#{full_name}</a>"
  end
end
