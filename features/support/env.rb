# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../../../../config/environment') # Radiant root's env
require 'cucumber/rails/world'
require 'cucumber/rails/rspec'
Cucumber::Rails.use_transactional_fixtures

Fixtures.reset_cache  
fixtures_folder = File.expand_path(File.dirname(__FILE__) + '/../../spec/fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
Fixtures.create_fixtures(fixtures_folder, fixtures)

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'

