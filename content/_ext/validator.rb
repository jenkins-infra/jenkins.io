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

    site.logo.each do |id, logo|
      if !logo['name']
        warning "Missing name for logo #{id}"
      end
      check_file(logo['url'], "`url` of the logo #{id}")
      check_file(logo['url_256'], "`url_256` of the logo #{id}") unless logo['url_256'].nil?
      check_file(logo['vector'], "`vector` of the logo #{id}") unless logo['vector'].nil?
      if !logo['url_256'] && !logo['vector']
         warning "Either vector image or 256px preview must be defined for logo #{id}"
      end
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

  def check_file(path, context)
    full = "#{File.dirname(__FILE__)}/..#{path}"
    puts File.expand_path(full)
    if !File.file?(full)
      warning "Invalid file path #{path} for #{context}"
    end
  end

end
