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
    Radiant::Config.class_eval { include ConfigProtection }
    
    tab 'Settings' do
      add_item 'Application', '/admin/settings', :after => 'Extensions'
    end
    
    Page.class_eval { include SettingsTags }
    
    Radiant::AdminUI.class_eval do
      attr_accessor :settings
    end
    admin.settings = load_default_settings_regions
  end
  
  def deactivate
  end
  
  def load_default_settings_regions
    returning OpenStruct.new do |settings|
      settings.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end
  
end
