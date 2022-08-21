# The authorship helper helps display authorship for a given entity
#
# This only renders something if the author(s) has put information in
# content/_data/authors and the document has an `author` or `authors` attribute in its
# front-matter
require 'authorlist.rb'
module Authorship
  include AuthorList::AuthorLink

  def display_author_for(node)
    if node.author
      display_user(node.author)
    elsif node.authors
      display_users(node.authors)
    else
      return
    end
  end

  def display_users(users)
    res = Array.new
    users.each { |user|
      res << display_user(user)
    }
    return res.join('')
  end

  def display_user(author)
    if site.authors.has_key? author.to_sym
      full_name = site.authors[author].name
      avatar = site.authors[author].avatar
    else
      raise "File with personal information (content/_data/authors/#{author}.adoc) is missing"
    end

    link = author_link(author)

    return "<a class=\"app-author-link\" href=\"#{link}\"><div class=\"app-author-image\"><img src=\"#{avatar}\"></div> #{full_name}</a>"
  end

  def display_user_optional(author)
    return display_user(author) unless author == "TBD"
    return author
  end
end
