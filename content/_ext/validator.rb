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
         validate_accessibility page
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
      if !logo['url_256'] && !logo['vector']
         warning "Either vector image or 256px preview must be defined for logo #{id}"
      check_file("/images/#{logo['url']}", "`url` of the logo #{id}")
      check_file("/images/#{logo['url_256']}", "`url_256` of the logo #{id}") unless logo['url_256'].nil?
      check_file("/images/#{logo['vector']}", "`vector` of the logo #{id}") unless logo['vector'].nil?
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
      # https://issues.jenkins.io/browse/WEBSITE-270
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
    if !File.file?(full)
      warning "Invalid file path #{path} for #{context}"
    end
  end

  # Validate accessibility requirements for pages
  # Checks for WCAG 2.1 Level A compliance
  def validate_accessibility(page)
    return unless page.content
    
    # Check for images without alt text
    check_image_alt_text(page)
    
    # Check for buttons and links that might need ARIA labels
    check_aria_labels(page)
  end

  def check_image_alt_text(page)
    # Find all img tags - both HAML and HTML
    img_pattern = /%img\{[^}]*\}|<img[^>]*>/i
    page.content.scan(img_pattern).each do |img_tag|
      # Check if alt attribute is missing
      unless img_tag.match(/:alt\s*=>|alt\s*=/i)
        warning "Missing alt text on image in #{page.output_path}: #{img_tag.strip[0..80]}"
      else
        # Check for generic/poor alt text
        alt_match = img_tag.match(/:alt\s*=>\s*['"](.*?)['"]|alt\s*=\s*['"](.*?)['"]/i)
        if alt_match
          alt_text = (alt_match[1] || alt_match[2]).to_s.strip.downcase
          generic_terms = ['image', 'img', 'logo', 'icon', 'picture', 'photo']
          
          if generic_terms.include?(alt_text)
            warning "Generic alt text '#{alt_text}' in #{page.output_path} - should be more descriptive"
          end
        end
      end
    end
  end

  def check_aria_labels(page)
    # Find buttons and links with only icons (no text content)
    # Look for patterns like %button, %a with only ion-icon or svg inside
    icon_only_pattern = /(%button|%a)(\{[^}]*\})?[^%\n]*(%ion-icon|<svg|<ion-icon)/i
    
    page.content.scan(icon_only_pattern).each do |match|
      element_line = page.content[page.content.index(match[0])..page.content.index(match[0]) + 150]
      
      # Check if there's an aria-label or aria-labelledby
      unless element_line.match(/aria-label|aria-labelledby/i)
        warning "Interactive element with icon needs aria-label in #{page.output_path}"
      end
    end
  end

end
