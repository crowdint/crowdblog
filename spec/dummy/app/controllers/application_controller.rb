class ApplicationController < ActionController::Base
  def authenticate_user!
    true
  end

  def current_user
    User.last
  end

  def crowdblog_current_user
    current_user
  end

  def crowdblog_authenticate_user!
    authenticate_user!
  end

  helper_method :crowdblog_current_user, :crowdblog_authenticate_user!
end
