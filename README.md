# CrowdBlog

CI:
[![Build Status](https://secure.travis-ci.org/crowdint/crowdblog.png?branch=master)](http://travis-ci.org/crowdint/crowdblog)

Code Climate:
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/crowdint/crowdblog)

Generic Blog engine, currently in use by [blog.crowdint.com](blog.crowdint.com)
and [crowdint.com/careers](crowdint.com/careers), among others.

## Installation

Gemfile

    gem 'crowdblog'

Bundle

    bundle install

Copy migrations

    rake crowdblog:install:migrations

Run them

    rake db:migrate

Mount

    #
    # routes.rb
    #

    mount Crowdblog::Engine => '/blog_admin'

Enjoy.

Your Rails App should implement the "client facing" pages. Read posts from the
Crowdblog::Post model.

### Authentication

The gem includes a very basic Devise implementation. We use it in combination
with [this gem](https://github.com/crowdint/crowdint_auth) to authenticate
via our Google Apps accounts.

Take a look [at this code](https://github.com/crowdint/blog.crowdint.com) as an implementation example.

## Testing: Use with caution

If you are using it as a 'vanilla' installation, that is, without a lot of
customizations, you can use some specs that are included with the gem to make
sure your blog behaves properly.

Add this on your spec_helper, right after you require `rspec/rails`:

    require 'crowdblog/rspec'
    require 'database_cleaner'

Your are going to need DatabaseCleaner to use truncation strategies for your
data. Add these lines to spec_helper.rb:

    Rspec.configure do |config|

      config.use_transactional_fixtures = false

      config.before(:suite) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean_with(:truncation)
      end

      config.before(:each) do
        DatabaseCleaner.start
      end

      config.after(:each) do
        DatabaseCleaner.clean
      end
    end

Now, create a crowdblog spec:

    #
    # spec/integration/crowdblog_spec.rb
    #
    require 'spec_helper'

    describe "Crowdblog" do
      it_behaves_like "a crowdblog"
    end

And run your specs. It should test Crowdblog properly.

[Crowd Interactive](http://www.crowdint.com) is a leading Ruby and Rails consultancy
firm based in Mexico currently doing business with startups in the United States.
We specialize in building and growing your existing development team, by adding
engineers onsite or offsite. We pick our clients carefully, as we only work with
companies we believe in. Find out more about us on our [website](http://www.crowdint.com).

