module Crowdblog
  class ApplicationController < ActionController::Base
    def method_missing(method_name)
      if method_name == :current_user
        Rails.logger.warn("current_user in Crowdblog::ApplicationController should be overriden")
        User.new
      end
    end

    helper_method :current_user
  end
end
