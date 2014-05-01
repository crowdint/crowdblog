module Crowdblog
  class StatusChangeRecord < ActiveRecord::Base
    belongs_to :post
    belongs_to :user
  end
end
