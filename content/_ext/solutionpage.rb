require 'awestruct/page'

# The SolutionPage helper will set up the solution page short-links for
# marketing purposes under /s/$foo
#
# The pages are equivalent
class SolutionPage
  def execute(site)
    solutions = site.pages.select { |p| p.source_path =~ /solutions/ }

    solutions.each do |solution|
      page = site.engine.load_page(solution.source_path)
      page.output_path = "/s/#{File.basename(solution.source_path, File.extname(solution.source_path))}/index.html"
      site.pages << page
    end
  end
end
