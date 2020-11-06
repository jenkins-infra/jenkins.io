require 'awestruct/extensions/posts'

# YearPosts is a modification of the `Posts` extension with support for the
# path/year/filename directory structure which accomodates larger sets of content
class YearPosts < Awestruct::Extensions::Posts
  def execute(site)
    posts   = []
    archive = Awestruct::Extensions::Posts::Archive.new

    site.pages.each do |page|
      year, month, day, slug = nil

      if ( page.relative_source_path =~ /^#{@path_prefix}\// )
        # check for a date inside the page first
        if (page.date?)
          page.relative_source_path =~ /^#{@path_prefix}\/(.*)\..*$/
          date = page.date
          unless date.kind_of? DateTime
            if date.kind_of? String
              date = DateTime.parse date
            elsif date.kind_of? Date
              date = DateTime.new(date.year, date.month, date.day)
            elsif date.kind_of? Time
              date = date.to_datetime
            end
          end
          year = date.year
          month = sprintf( "%02d", date.month )
          day = sprintf( "%02d", date.day )
          page.date = date
          slug = $1
          if ( page.relative_source_path =~ /^#{@path_prefix}\/(20[012][0-9])-([01][0-9])-([0123][0-9])-([^.]+)\..*$/ )
            slug = $4
          end
        elsif ( page.relative_source_path =~ /^#{@path_prefix}\/.*\/(20[012][0-9])-([01][0-9])-([0123][0-9])-([^.]+)\..*$/ )
          year  = $1
          month = $2
          day   = $3
          slug  = $4
          page.date = DateTime.new( year.to_i, month.to_i, day.to_i )
        end

        # if a date was found create a post
        if( year and month and day)
          page.layout ||= @default_layout if @default_layout
          page.slug ||= slug
          context = page.create_context
          page.output_path = "#{@path_prefix}/#{year}/#{month}/#{day}/#{page.slug}.html"
          posts << page
        end
      end
    end

    posts = posts.sort_by{|each| [each.date, each.sequence || 0, File.mtime( each.source_path ), each.slug ] }.reverse

    last = nil
    singular = @assign_to.to_s.singularize
    posts.each do |e|
      if ( last != nil )
          e.send( "next_#{singular}=", last )
          last.send( "previous_#{singular}=", e )
      end
      last = e
      archive << e
    end
    site.pages.concat( archive.generate_pages( site.engine, archive_template, archive_path ) ) if (archive_template && archive_path)
    site.send( "#{@assign_to}=", posts )
    site.send( "#{@assign_to}_archive=", archive )

  end
end
