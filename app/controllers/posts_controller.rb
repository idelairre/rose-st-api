class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.where(title_url: params[:title_url]).first
    render json: @post
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    # @post.image = params[:file]
    @post.save
    render json: @post
  end

  def update
    @post = Post.where(title_url: params[:title_url]).first
    @post.update(post_params)
    render json: @post
  end

  def destroy
    @post = Post.where(title_url: params[:title_url]).first.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :title_url, :body, :subheading, :user_id)
  end
end
