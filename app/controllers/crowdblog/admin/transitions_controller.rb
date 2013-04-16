module Crowdblog
  module Admin
    class TransitionsController < Crowdblog::Admin::BaseController
      respond_to :json
      before_filter :load_post, only: [:create]

      def create
        namespace = '_as_publisher' if crowdblog_current_user.is_publisher?
        @post.send "#{params[:transition]}#{namespace}"
        respond_with @post, location: admin_post_url(@post)
      end

      private

      def load_post
        post  = Post.scoped_for(crowdblog_current_user).find(params[:id])
        @post = PostPresenter.new(post, crowdblog_current_user)
      end
    end
  end
end
