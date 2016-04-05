
module ActiveNav
  def active_link?(section_name, options={:css_class => 'active'})
    return options[:css_class] if page.section == section_name
  end
end
