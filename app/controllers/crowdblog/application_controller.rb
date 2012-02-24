module Crowdblog
  class ApplicationController < ActionController::Base
    include Crowdblog::Devise::Auth
    before_filter :authenticate!
  end
end
