module Crowdblog
  module Admin
    class BaseController < Crowdblog::ApplicationController
      before_filter :authenticate_user!
    end
  end
end
