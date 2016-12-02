
module ActiveNav
  def active_link?(section_name, options={:css_class => 'active'})
    return options[:css_class] if page.section == section_name
  end

  def expand_link(relative_url)
    return [site.base_url, relative_url].join('/')
  end
end
