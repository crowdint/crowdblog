module Crowdblog
  class Controller < ActionController::Base
    before_filter :authentication_filter

    def authentication_filter
      authenticate_user!
    end
  end
end
