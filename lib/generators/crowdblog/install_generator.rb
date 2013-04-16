require 'rails/generators'
require 'colorize'

module Crowdblog
  module Generators
    # This generator setups the user_class, current_user, and authenticate methods, copies migrations and mounts the engine on the application where will be used.
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", type: :string
      class_option "current-user-helper", type: :string
      class_option "authenticate-user-helper", type: :string
      class_option "no-migrate", type: :boolean

      source_root File.expand_path('../templates', __FILE__)
      desc "Use this generator to install Crowdblog: Setups the user_class, current_user, and authenticate methods, copies migrations and mounts the engine on the application where will be used. ".colorize(:yellow)

      def install_migrations
        unless options['no-migrate']
          puts 'Copying migrations from Crowdblog...'.colorize(:blue)
          Dir.chdir(Rails.root) do
            `rake crowdblog:install:migrations`
          end
        end
      end

      def determine_user_class
        @user_class = options['user-class'].presence ||
          ask('What is your user class called? [User]'.colorize(:yellow)).presence ||
          'User'
          puts "Defining crowdblog_user_class method inside ApplicationController...".colorize(:blue)
      end

      def determine_current_user_helper
        @current_user_helper = options["current-user-helper"].presence ||
          ask("What is the current_user helper called in your app? [current_user]".colorize(:yellow)).presence ||
          :current_user
        puts "Defining crowdblog_current_user method inside ApplicationController...".colorize(:blue)
      end

      def determine_authenticate_user_helper
        @authenticate_user_helper = options["authenticate_user_helper"].presence ||
        ask("What is your authenticate! method called in your app? [authenticate_user!]".colorize(:yellow)).presence || :authenticate_user!
        puts "Defining crowdblog_authenticate_user! method inside ApplicationController...".colorize(:blue)
      end

      def injects_wrappers

        wrappers = %Q{
  def crowdblog_current_user
    #{@current_user_helper}
  end

  def crowdblog_authenticate_user!
    #{@authenticate_user_helper}
  end

  helper_method :crowdblog_current_user, :crowdblog_authenticate_user!
  
}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb", wrappers, after: "ActionController::Base\n")


      end

      def add_crowdblog_initializer
        path = "#{Rails.root}/config/initializers/crowdblog.rb"

        if File.exists? path
          puts "Skipping config/initializers/crowdblog.rb creation, file already exists!".colorize(:red)
        else
          puts "Adding crowdblog initializer (config/initializers/crowdblog.rb)...".colorize(:blue)
          template "initializer.rb", path
        end
      end

      def run_migrations
        unless options['no-migrate']
          puts 'Running rake:db:migrate'.colorize(:blue)
          `rake db:migrate`
        end
      end

      def mount_engine
        puts 'Mounting KarmaApp engine at "/blog" inf config/routes.rb ...'.colorize(:blue)

        insert_into_file( "#{Rails.root}/config/routes.rb", after: /routes.draw.do\n/) do
  %Q{
# This line mounts Crowdblog's routes at /blog by default.
# This means, any requests to the /blog URL of your application will go to Crowdblog::home#index.
# If you would like to change where this extension is mounted, simply change the :at option to something different.
#
# We ask that you don't use the :as option here, as Forem relies on it being the default of "crowdblog"
  mount Crowdblog::Engine, :at => '/blog'

}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nCrowdblog has been successfully installed.}.colorize(:green)
        output += "Thanks for using KarmaApp!".colorize(:green)
        puts output
      end

      private

      def user_class
        @user_class
      end
    end
  end
end
