module  Crowdblog
  class SessionsController < Controller
    include Crowdblog::Devise::Sessions
  end
end
