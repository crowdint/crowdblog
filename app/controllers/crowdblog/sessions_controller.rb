module  Crowdblog
  class SessionsController < ApplicationController
    include Crowdblog::Devise::Sessions
  end
end
