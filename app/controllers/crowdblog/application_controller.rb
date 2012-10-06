module Crowdblog
  class ApplicationController < ActionController::Base
    before_filter :authentication_filter

    def authentication_filter
      authenticate_user!
    end

    def after_sign_out_path_for(resource_or_scope)
      crowdblog.new_user_session_path
    end
  end
end
