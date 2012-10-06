module  Crowdblog
  class PostsController < ApplicationController
    respond_to :html, :json
    cache_sweeper :post_sweeper

    def new
      @post = Post.new
    end

    def index
      @posts = Post.scoped_for(current_user)
      respond_with @posts
      #respond_to do |format|
        #format.json { render json: @posts }
        #format.html
      #end
    end

    def create
      @post = Post.new(params[:post])
      @post.author = current_user
      @post.regenerate_permalink
      if @post.save
        respond_with @post, :location => crowdblog.posts_path
      end
    end

    def destroy
      @post = Post.scoped_for(current_user).find(params[:id])
      @post.destroy
      respond_with @post, :location => crowdblog.posts_path
    end

    def show
      @post = Post.includes(:assets).find(params[:id])
      respond_to do |format|
        format.json { render json: @post.to_json(include: :assets) }
      end
    end

    def edit
      @post = Post.scoped_for(current_user).find(params[:id])
    end

    def update
      @post = Post.scoped_for(current_user).find(params[:id])
      @post.update_attributes(params[:post], updated_by: current_user)
      if @post.allowed_to_update_permalink?
        @post.regenerate_permalink
        @post.save!
      end

      @post.publish_if_allowed(params[:transition], current_user) if params[:transition]

      respond_with @post, location: crowdblog.posts_path
    end
  end
end
