class AddDescriptionToConfig < ActiveRecord::Migration
  
  class Config < ActiveRecord::Base; end
  
  def self.up
    add_column :config, :description, :text
    
    puts "-- Adding description for base radiant settings"
    
    
    Config.find(:all).each do |c|
      description = case c.key
        when 'admin.title'
          'Title text displayed at the top of all administration screens.'
        
        when 'admin.subtitle'
          'The tagline displayed underneath the main administration title'
        
        when 'defaults.page.parts'
          <<-DESC
Defines the page parts that a new page is created with.  It should be a list, separated by a comma and a space.  For example:

bq. @body, extended, sidebar@
DESC
        
        when 'defaults.page.status'
          <<-DESC
Defines the publishing status of new pages.  This can any one of:

* draft
* published
* reviewed
* hidden
DESC
        when 'defaults.page.filter'
          <<-DESC
Sets the text filter a new page has by default.  Valid options, in a vanilla Radiant install are:

* _leave blank to set no default filter_
* Markdown
* SmartyPants
* Textile
DESC
      end
      
      c.update_attribute :description, description
    end
  end

  def self.down
    remove_column :config, :description
  end
end