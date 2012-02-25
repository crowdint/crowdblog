source "http://rubygems.org"

# Declare your gem's dependencies in crowdblog.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Gems used by the dummy application (needs to be here instead of the gemspec)
gem "jquery-rails"
gem 'backbone-rails'
gem 'carrierwave'
gem 'devise'
gem 'gravtastic'
gem 'less-rails-bootstrap'
gem 'state_machine'
gem 'slim_assets'
gem 'slim-rails'
gem 'eco'

group :assets do
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'fabrication'
  gem 'faker'
  gem 'rake' # needed for Travis CI: http://bit.ly/xEgH8j
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.
gem 'vestal_versions', :git => 'https://github.com/jodosha/vestal_versions.git'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
