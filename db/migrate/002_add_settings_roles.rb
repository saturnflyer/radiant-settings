class AddSettingsRoles < ActiveRecord::Migration
  
  class Config < ActiveRecord::Base; end
  
  def self.up
    Config.create!(:key => 'roles.settings', :value => 'admin', :description => 'List of user roles that may see the settings tabs.')
  end
  
  def self.down
    # Not really necessary
  end
  
end