module Crowdblog
  module Admin
    class BaseController < Crowdblog::ApplicationController
      before_filter :crowdblog_authenticate_user!
    end
  end
end
