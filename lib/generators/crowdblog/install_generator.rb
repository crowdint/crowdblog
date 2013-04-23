require 'rails/generators'
require 'colorize'

module Crowdblog
  # This generator setups the user_class, current_user, and authenticate methods, copies migrations and mounts the engine on the application where will be used.
  class InstallGenerator < Rails::Generators::Base
    class_option "user-class", type: :string
    class_option "current-user-helper", type: :string
    class_option "authenticate-user-helper", type: :string
    class_option "no-migrate", type: :boolean

    source_root File.expand_path('../templates', __FILE__)
    desc "Use this generator to install Crowdblog: Setups the user_class, current_user, and authenticate methods, copies migrations and mounts the engine on the application where will be used. ".colorize(:yellow)

    def determine_user_class
      @user_class = options['user-class'].presence ||
        ask('What is your user class called? [User]'.colorize(:yellow)).presence || 'User'
    end

    def determine_current_user_helper
      @current_user_helper = options["current-user-helper"].presence ||
        ask("What is the current_user helper called in your app? [current_user]".colorize(:yellow)).presence ||
        :current_user
    end

    def determine_authenticate_user_helper
      @authenticate_user_helper = options["authenticate-user-helper"].presence ||
      ask("What is your authenticate! method called in your app? [authenticate_user!]".colorize(:yellow)).presence || :authenticate_user!
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
      puts 'Methods successfully injected into /app/controllers/application_controller.rb'.colorize(:green)
    end

    def add_crowdblog_initializer
      path = "#{Rails.root}/config/initializers/crowdblog.rb"

      if File.exists? path
        puts "Skipping config/initializers/crowdblog.rb creation, file already exists!".colorize(:light_red)
      else
        template "initializer.rb", path
        puts "Crowdblog initializer added (config/initializers/crowdblog.rb)...".colorize(:green)
      end
    end

    def install_migrations
      unless options['no-migrate'] 
        Dir.chdir(Rails.root) do
          `rake crowdblog:install:migrations`
           puts 'Migrations copied from Crowdblog...'.colorize(:green)
        end
      end
    end

    def run_migrations
      unless options['no-migrate'] 
        `rake db:migrate`
        puts 'Migrations ran successfully'.colorize(:green)
      end
    end

    def mount_engine
      puts 'Crowdblog engine mounted at "/blog" in config/routes.rb ...'.colorize(:green)

      insert_into_file( "#{Rails.root}/config/routes.rb", after: /routes.draw.do\n/) do
%Q{
# This line mounts Crowdblog's routes at /blog by default.
# This means, any requests to the /blog URL of your application will go to Crowdblog::posts#index.
# If you would like to change where this extension is mounted, simply change the :at option to something different.
#
# We ask that you don't use the :as option here, as Forem relies on it being the default of "crowdblog"
mount Crowdblog::Engine => '/blog'

}
      end
    end

    def finished
      output = "\n" + ("*" * 53)
      output += %Q{\nCrowdblog has been successfully installed.}
      output += "\nThanks for using Crowdblog! :*"
      puts output.colorize(:green)
    end

    private

    def user_class
      @user_class
    end
  end
end
