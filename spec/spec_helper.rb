require 'spork'

Spork.prefork do
  require 'simplecov'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  Capybara.javascript_driver = :webkit
end

Spork.each_run do
  ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

  Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each {|f| load f }
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/lib/**/*.rb"].each {|f| load f}

  RSpec.configure do |config|
    config.fixture_path = "#{ENGINE_RAILS_ROOT}/spec/fixtures"

    config.use_transactional_fixtures = true

    config.infer_base_class_for_anonymous_controllers = false

    config.include Crowdblog::Engine.routes.url_helpers
  end
end
