
module GetPlugins

  Plugin = Struct.new(:name, :title)

  def get_plugins(issues)
    issues.collect { |issue| issue.plugins }.flatten.keep_if { |p| p }.collect { |p| Plugin.new(p.name, p.title) }
  end

end
