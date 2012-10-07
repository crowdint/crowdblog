module  Crowdblog
  class AssetsController < Crowdblog::ApplicationController
    # TODO: Skipping filters is the worst solution ever to this problem
    # Someone should fix the uploadify.js thing
    skip_before_filter :verify_authenticity_token, :only => :create
    skip_before_filter :authorize!

    def create
      @post = Post.find(params[:post_id])
      asset = @post.assets.build
      asset.attachment = params['attachment']
      asset.save!

      render json: asset
    end

  end
end
