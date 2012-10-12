module Crowdblog
  class ApplicationController < ActionController::Base
    def current_user
      User.new
    end

    helper_method :current_user
  end
end
