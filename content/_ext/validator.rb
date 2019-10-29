class Validator
  def execute(site)
    @warnings = 0
    layouts = []
    site.pages.each do |page|
      next unless page.output_path =~ /\.html?/i
      if !page.layout
         warning "Missing layout for #{page.output_path}"
      elsif page.layout != "redirect" && page.layout != "refresh"
         validate_title page
      end
    end

    site.authors.each do |id, author|
      if !author.name
        warning "Missing name for author #{id}"
      end
      valid_nickname = /[^\/]+/
      check_format(author.twitter, valid_nickname)
      check_format(author.github, valid_nickname)
      check_format(author.linkedin, valid_nickname)
      check_format(author.blog, /https?:\/\/.*/)
    end

    github_groups = site.authors.values.group_by {|x| x.github}
    duplicates = github_groups.select {|gh, group| gh && group.length > 1}
    if duplicates.length > 0
       warning "Duplicate author entries for github users #{duplicates.keys}"
    end

    if @warnings > 0
      raise "Found #{@warnings} issues, see log messages above"
    end
  end

  def validate_title(page)
    if !page.title
      warning "Missing title for #{page.output_path}"
    else
      # Workaround for title parsing bug
      # https://issues.jenkins-ci.org/browse/WEBSITE-270
      if page.title.is_a?(Hash) and page.title.keys.length == 1
        page.title.each do |key, val|
          page.title = "#{key}: #{val}"
        end
      end
      warning "Invalid title #{page.title} for #{page.output_path}" unless page.title.is_a?(String)
    end
  end
  
  def warning(message)
    puts "WARNING: #{message}"
    @warnings += 1
  end

  def check_format(value, regexp)
    if value and !value.match(regexp)
      warning "Invalid attribute value #{value}"
    end
  end

end
