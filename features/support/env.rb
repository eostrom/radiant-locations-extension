# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + '/../../../../../config/environment') # Radiant root's env
require 'cucumber/rails/world'
Cucumber::Rails.use_transactional_fixtures

require 'scenarios'
[
  '../../../../radiant/spec/scenarios',
  '../../spec/scenarios'
].each do |path|
  Scenarios::load_paths.unshift(File.expand_path(path, File.dirname(__FILE__)))
end
Scenarios::load :features

require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'

