module Crowdblog
  class Controller < ActionController::Base
    include Crowdblog::Devise::Auth
    layout 'crowdblog/crowdblog'
    before_filter :authenticate!
  end
end
