class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find_by(params[:title])
    render json: @post
  end

  def new
  end

  def create
    @post = Post.create(post_params)
    render json: @post
  end

  def update
    @post = Post.find_by(params[:title])
    @post.update(post_params)
    render json: @post
  end

  def destroy
    @post = Post.find_by(params[:title]).destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :subheading, :user_id)
  end
end
