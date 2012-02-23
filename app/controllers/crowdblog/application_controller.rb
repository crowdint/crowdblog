module Crowdblog
  class ApplicationController < ActionController::Base
    before_filter :authenticate!

    def authenticate!
      unless user_signed_in?
        current_user = User.find_by_email('foo@crowdint.com') || User.create!(email: 'foo@crowdint.com', is_publisher: true)
        sign_in current_user
      end

      #TODO: fix OAuth
      #redirect_to user_omniauth_authorize_path(:google_apps) unless current_user
    end

  end
end
