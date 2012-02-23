$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'crowdblog_core/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'crowdblog-core'
  s.version     = CrowdblogCore::VERSION
  s.authors     = ['Crowd Interactive', 'David Padilla','Chalo Fernandez']
  s.email       = %w(opensource@crowdint.com david@crowdint.com chalofa@crowdint.com)
  s.homepage    = 'http://github.com/crowdint/crowdblog-core'
  s.summary     = 'CrowdBlog core functionality and backend'
  s.description = 'This mountable engine will allow CrowdBlog manage Posts and Authentication'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 3.2'

  # Added in the Gemfile, so they can be accessed in the dummy app
  #   leave the dependencies here so our engine require those gems when added on base apps
  s.add_dependency 'jquery-rails'
  s.add_dependency 'carrierwave'
  s.add_dependency 'devise'
  s.add_dependency 'gravtastic'
  s.add_dependency 'omniauth-google-apps'
  s.add_dependency 'omniauth-google-oauth2'
  s.add_dependency 'state_machine'

  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov-text'
  s.add_development_dependency 'sqlite3'
  #s.add_development_dependency 'vestal_versions' # using git version in Gemfile
end
