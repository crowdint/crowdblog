# CrowdBlog

CI:
[![Build Status](https://secure.travis-ci.org/crowdint/crowdblog.png?branch=master)](http://travis-ci.org/crowdint/crowdblog)

Code Climate:
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/crowdint/crowdblog)

Generic Blog engine, currently in use by [blog.crowdint.com](blog.crowdint.com)
and [crowdint.com/careers](crowdint.com/careers), among others.

This branch has two majors changes:

- Supports rails4.0.0-beta1 (and will support newer versions in the 4.x branch)
- Does not contain logic for the User model and delegates its implementation to the host application (see 'About the installer section').

## Installation

Gemfile

    gem 'crowdblog', github: 'crowdint/crowdblog', branch: 'rails4-userless'

Bundle

    bundle install

Run installer

    rails generate crowdblog:installer

Uou will be asked for the name of some methods that you use in your main application and will allow crowdblog to create the wrappers needed for the engine to communicate with your application

### About the installer

Since the engine does not handle neither the authentication nor the logic of the users, you host application needs to provide the name of the model that contains users' information. Eventhough 'User' is used by default, this model is not tied to a specific name but it is required that the model has at least two fields: name and email. 

You also have to create methods equivalent to the functionality of the following ones:

##### crowdblog\_current\_user

This method must return the object of the User class that corresponde to the user who is currently logged in

##### crowdblog\_authenticate_user!

Returns a boolean value indicating if the current user is allowed to access the application.



These methods must be implemented in your application\_controller and can be named however you want but must have exactly the same name that the indicated when using the installer.

Run your host application and go to /blog to access the engine.

Your Rails App should implement the "client facing" pages. Read posts from the
Crowdblog::Post model.

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

