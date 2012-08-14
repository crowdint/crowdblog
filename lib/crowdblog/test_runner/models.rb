module Crowdblog
  module TestRunner
    module Models
      extend self

      def create_user
        Crowdblog::User.find_by_email('test@crowdint.com') ||
        Fabricate(:user_test)
      end

      def create_post *args
        post_type = args.first || :post
        user = (args.first && args.last[:author]) || Fabricate(:user)
        Fabricate post_type, author: user
      end
    end
  end
end
