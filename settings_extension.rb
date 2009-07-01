# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class SettingsExtension < Radiant::Extension
  version "1.1"
  description "Web based administration for Radiant default configuration settings."
  url "http://github.com/Squeegy/radiant-settings"
  
  define_routes do |map|
    map.namespace 'admin' do |admin|
      admin.resources :settings
    end
  end
  
  def activate
    Radiant::Config.extend ConfigFindAllAsTree
    Radiant::Config.send :include, ConfigProtection
    
    if Radiant::Config['roles.settings']
      config_roles = Radiant::Config['roles.settings']
      roles = []
      roles << :developer if config_roles.include?('developer')
      roles << :admin if config_roles.include?('admin')
      if config_roles.include?('all')
        roles = [:all]
      end
    end
    admin.tabs.add "Settings", "/admin/settings", :after => "Layouts" , :visibility => roles
    
    Page.class_eval {
      include SettingsTags
    }
    
    Radiant::AdminUI.class_eval do
      attr_accessor :settings
    end
    admin.settings = load_default_settings_regions
  end
  
  def deactivate
    admin.tabs.remove "Settings"
  end
  
  def load_default_settings_regions
    returning OpenStruct.new do |settings|
      settings.index = Radiant::AdminUI::RegionSet.new do |index|
        index.main.concat %w{top list bottom}
      end
    end
  end
  
end
