$:.push File.expand_path('../lib', __FILE__)

require 'crowdblog/version'

Gem::Specification.new do |s|
  s.name        = 'crowdblog'
  s.version     = Crowdblog::VERSION
  s.authors     = ['Crowd Interactive', 'David Padilla', 'Chalo Fernandez', 'Ignacio Galindo', 'Nora Alvarado']
  s.email       = %w(opensource@crowdint.com david@crowdint.com chalofa@crowdint.com ignacio@crowdint.com nora@crowdint.com)
  s.homepage    = 'http://github.com/crowdint/crowdblog'
  s.summary     = 'CrowdBlog base functionality and backend'
  s.description = 'This mountable engine has the basic functionality to manage Posts'

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib app)

  s.add_dependency 'rails', '~> 3.2'

  s.add_dependency 'carrierwave'
  s.add_dependency 'gravtastic'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jbuilder'
  s.add_dependency 'redcarpet'
  s.add_dependency 'slim'
  s.add_dependency 'state_machine'
  s.add_dependency 'strong_parameters'

  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov-text'
  s.add_development_dependency 'sqlite3'
end
