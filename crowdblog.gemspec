$:.push File.expand_path('../lib', __FILE__)

require 'crowdblog/version'

Gem::Specification.new do |s|
  s.name        = 'crowdblog'
  s.version     = Crowdblog::VERSION
  s.authors     = ['Crowd Interactive', 'David Padilla', 'Chalo Fernandez', 'Ignacio Galindo', 'Nora Alvarado', 'Mario Chavez']
  s.email       = %w(opensource@crowdint.com david@crowdint.com chalofa@crowdint.com ignacio@crowdint.com nora@crowdint.com mario.chavez@crowdint.com)
  s.homepage    = 'http://github.com/crowdint/crowdblog'
  s.summary     = 'CrowdBlog base functionality and backend'
  s.description = 'This mountable engine has the basic functionality to manage Posts'
  s.license     = 'MIT'

  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = %w(lib app)

  s.add_dependency 'rails', '~> 4.1'

  s.add_dependency 'carrierwave', '~> 0.10.0'
  s.add_dependency 'gravtastic', '~> 3.2.6'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jbuilder'
  s.add_dependency 'redcarpet', '~> 3.1.0'
  s.add_dependency 'responders'
  s.add_dependency 'slim', '~> 2.0.0'
  s.add_dependency 'state_machine', '~> 1.2.0'

  s.add_development_dependency 'capybara-webkit', '~> 1.0.0'
  s.add_development_dependency 'database_cleaner', '~> 1.3.0'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-activemodel-mocks'
  s.add_development_dependency 'selenium-webdriver', '>=2.45.0.dev3'
  s.add_development_dependency 'simplecov', '~> 0.9.0'
  s.add_development_dependency 'simplecov-rcov-text'
  s.add_development_dependency 'sqlite3'
end
