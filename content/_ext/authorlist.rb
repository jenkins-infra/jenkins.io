require 'awestruct/page'

# Based heavily on the Tagger extension:
# https://github.com/awestruct/awestruct/blob/master/lib/awestruct/extensions/tagger.rb 
#
class AuthorList
   module AuthorLink
     def author_link(string)
       #replace accents with unaccented version, go lowercase and replace and space with dash
       "/blog/authors/" + string.to_s.urlize({:convert_spaces=>true})
     end
   end      
   
   include AuthorLink

   def initialize(tagged_items_property, input_path, opts={})
     @tagged_items_property = tagged_items_property
     @input_path  = input_path
     @pagination_opts = opts
   end

   def execute(site)
     @authors ||= {}
     all = site.send( @tagged_items_property )
     return if ( all.nil? || all.empty? ) 
     all.each do |page|
       author = page.author
       if ( author )
         author = author.to_s
         @authors[author] ||= Awestruct::Extensions::Tagger::TagStat.new( author, [] )
         @authors[author].pages << page
       end
     end

     ordered_authors = @authors.values
     # secondary sort: user ID
     ordered_authors.sort!{|l,r| l.to_s <=> r.to_s}
     # primary sort: number of posts
     ordered_authors.sort!{|l,r| -(l.pages.size <=> r.pages.size)}

     @authors.values.each do |author|
       output_prefix = author_link(author.to_s)
       options = { :remove_input=>false, :output_prefix=>output_prefix, :collection=>author.pages, :selected_tag=>author.to_s }.merge( @pagination_opts )
          
       paginator = Awestruct::Extensions::Paginator.new( @tagged_items_property, @input_path, options )
       primary_page = paginator.execute( site )
       primary_page.author = author.to_s
       author.primary_page = primary_page
       site.send( "#{@tagged_items_property}_authors=", ordered_authors )
       author.pages.each {|p| primary_page.dependencies.add_dependency(p)}
     end

   end

end
