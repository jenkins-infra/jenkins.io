class Validator
  def execute(site)
    warnings = 0
    layouts = []
    site.pages.each do |page|
      next unless page.output_path =~ /\.html?/i
      if !page.layout
         warnings += 1
         puts "WARNING: Missing layout for #{page.output_path}"
      elsif page.layout != "redirect" && page.layout != "refresh" && !page.title
         warnings += 1
         puts "WARNING: Missing title for #{page.output_path}"
      end
    end
    if warnings > 0
      raise "Found #{warnings} issues, see log messages above"
    end
  end
end
