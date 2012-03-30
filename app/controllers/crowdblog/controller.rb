module Crowdblog
  class Controller < ActionController::Base
    layout 'crowdblog/crowdblog'
    before_filter :authorize!

    def authorize!
      redirect_to main_app.user_sign_in_url
    end
  end
end
