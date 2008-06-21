module Admin::SettingsHelper
  def render_node(key, object, options = {})
    @depth ||= 0
    
    if object.is_a?(Radiant::Config)
      render :partial => 'setting', :locals => { :key => key, :setting => object, :hash => nil }
    else
      render :partial => 'setting', :locals => { :key => key, :setting => nil, :hash => object }
    end
  end
end
