namespace :radiant do
  namespace :extensions do
    namespace :settings do
      
      desc "Runs the migration of the Settings extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          SettingsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          SettingsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Settings to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[SettingsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(SettingsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  

      desc "Export settings"
      task :export => :environment do
        configs = Radiant::Config.find(:all).map do |config|
          {:key => config.key, :value => config.value, :description => config.description}
        end
        File.open('settings.yaml', 'w') do |f|
          YAML.dump(configs, f)
        end
      end

      desc "Import/Merge settings"
      task :import => :environment do
        if File.exist?("settings.yaml") 
          File.open("settings.yaml") do |f|
            configs = YAML.load(f)
            configs.each do |config|
              if c = Radiant::Config.find_by_key(config[:key])
                c.update_attributes(config)
              else
                Radiant::Config.create config
              end
            end
          end
        else
          puts "A file called settings.yaml with your settings should exist"
        end
      end

    end
  end
end
