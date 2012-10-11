module Crowdblog
  module Admin
    class BaseController < Crowdblog::ApplicationController
      include ::Devise::Controllers::Helpers
      before_filter :authenticate_user!

      def after_sign_out_path_for(resource_or_scope)
        crowdblog.new_user_session_path
      end
    end
  end
end
