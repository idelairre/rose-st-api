class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def new
  end

  def create
    @post = Post.create(post_params)
    render json: @post
  end

  def destroy
    @post = Post.find(params[:id]).destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
