module ConfigFindAllAsTree
  
  def find_all_as_tree
    returning(ActiveSupport::OrderedHash.new) do |result|
      
      db_key = (ActiveRecord::Base.connection.adapter_name.downcase == 'mysql' ? '`key`' : 'key')
      
      # For all settings
      find(:all, :order => db_key).each do |setting|
        
        # Split the setting path into an array
        path = setting.key.split('.')
        
        # Set the current level to the root of the hash
        current_level = result
        
        # iterate through all path levels
        path.each do |path_element|
          if path_element.equal?(path.last)
            # We are at the end of the path, so set the settting object as the value
            current_level[path_element] = setting
            
          else
            # Not at the end yet, so first make sure that there is a hash for this key
            current_level[path_element] ||= ActiveSupport::OrderedHash.new
            
            # Reset the curent level to this hash object for this key
            current_level = current_level[path_element]
          end
        end # if
      end # each
    end # returning
  end # find_all_as_tree
  
end # ConfigFindAllAsTree