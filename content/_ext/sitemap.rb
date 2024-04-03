class JenkinsSitemap < Awestruct::Extensions::Sitemap
  def valid_sitemap_entry(page)
    ret = super
    if ret && page.layout == 'redirect'
      # actually redirect pages should not be in sitemap
      ret = false
    end
    ret
  end
end
