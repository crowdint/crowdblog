module Crowdblog
  class StatusChangeRecord < ActiveRecord::Base
    belongs_to :post
    belongs_to :user, class_name: Crowdblog.publisher_user_class_name
  end
end
