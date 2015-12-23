# Helpers to determine whether or not we're generating a legacy version of the
# site or not
#

module Legacy
  def legacy?
    return !!ENV['LEGACY']
  end
end
