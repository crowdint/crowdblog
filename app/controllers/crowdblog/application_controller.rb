module Crowdblog
   class ApplicationController < ::ApplicationController

    helper_method :crowdblog_current_user, :crowdblog_authenticate_user!
    
    def crowdblog_current_user
      current_user
    end

    def crowdblog_authenticate_user!
      authenticate_user!
    end
  end
end
