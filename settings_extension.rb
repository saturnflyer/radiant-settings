# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

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
  end
  
  def deactivate
    admin.tabs.remove "Settings"
  end
  
end