source "http://rubygems.org"

gemspec

gem "jquery-rails"

group :assets do
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'sass-rails', '~> 4.0.0.beta1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'rake' # needed for Travis CI: http://bit.ly/xEgH8j
  gem 'launchy'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end
