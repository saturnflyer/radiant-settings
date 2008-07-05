# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SettingsExtension < Radiant::Extension
  version "1.0"
  description "Web based administration for Radiant default configuration settings."
  url "http://githib.com/Squeegy/radiant-settings"
  
  define_routes do |map|
    map.namespace 'admin' do |admin|
      admin.resources :settings
    end
  end
  
  def activate
    Radiant::Config.extend ConfigFindAllAsTree
    admin.tabs.add "Settings", "/admin/settings", :after => "Layouts" #, :visibility => [:developer]
    
    Page.class_eval {
      include SettingsTags
    }
  end
  
  def deactivate
    admin.tabs.remove "Settings"
  end
  
end