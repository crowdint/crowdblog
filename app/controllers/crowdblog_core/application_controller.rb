module CrowdblogCore
  class ApplicationController < ActionController::Base
    before_filter :authenticate!

    def authenticate!
      current_user = User.find_by_email('foo@crowdint.com') || User.create!(email: 'chalofa@crowdint.com', is_publisher: true)
      sign_in current_user

      #TODO: fix OAuth
      #redirect_to user_omniauth_authorize_path(:google_apps) unless current_user
    end

  end
end
