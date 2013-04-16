class ApplicationController < ActionController::Base
  def authenticate_user!
    true
  end

  def current_user
    User.last
  end
end
