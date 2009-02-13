namespace :radiant do
  namespace :extensions do
    namespace :locations do
      
      require 'cucumber/rake/task'
      Cucumber::Rake::Task.new(:features) do |t|
        t.rcov = true
        t.rcov_opts = %w{--exclude .rb --include-file vendor\/extensions\/locations\/app,vendor\/extensions\/locations\/lib}
        t.feature_pattern = File.dirname(__FILE__) + '/../../features/**/*.feature'
        t.step_pattern = File.dirname(__FILE__) + '/../../features/**/*.rb'
        t.cucumber_opts = "--format pretty"
      end
      task :features => 'db:test:prepare'
      
      desc "Runs the migration of the Locations extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LocationsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LocationsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Locations to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[LocationsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(LocationsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
