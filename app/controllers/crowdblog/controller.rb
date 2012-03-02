module Crowdblog
  class Controller < ActionController::Base
    layout 'crowdblog/crowdblog'
    before_filter :authorize!

    def authorize!
      redirect_to main_app.new_user_session_url unless current_user
    end
  end
end
