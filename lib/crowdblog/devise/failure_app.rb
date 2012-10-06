module Crowdblog
  module Devise
    class FailureApp < ::Devise::FailureApp
      def redirect_url
        crowdblog.new_user_session_path
      end
    end
  end
end
