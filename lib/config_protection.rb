module ConfigProtection
  def protected?
    key.match(/[p|P]assword/)
  end
  
  def protected_value
    if protected?
      return "********"
    else
      return value
    end
  end
end