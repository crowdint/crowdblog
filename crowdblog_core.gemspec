$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'crowdblog_core/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'crowdblog-core'
  s.version     = CrowdblogCore::VERSION
  s.authors     = ['Crowd Interactive', 'Chalo Fernandez']
  s.email       = %w(opensource@crowdint.com chalofa@crowdint.com)
  s.homepage    = 'http://github.com/crowdint/crowdblog-core'
  s.summary     = 'CrowdBlog core functionality and backend'
  s.description = 'This mountable engine will allow CrowdBlog manage Posts and Authentication'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 3.2'
  s.add_dependency 'jquery-rails'

  s.add_dependency 'carrierwave'
  s.add_dependency 'state_machine'

  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov-text'
  s.add_development_dependency 'sqlite3'
  #s.add_development_dependency 'vestal_versions' # using git version in Gemfile
end
