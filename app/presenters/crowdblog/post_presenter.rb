module Crowdblog
  class PostPresenter < SimpleDelegator
    def initialize(object, user)
      @user = user
      super(object)
    end

    def publish_as_publisher
      self.publisher = @user
      super
    end
  end
end
