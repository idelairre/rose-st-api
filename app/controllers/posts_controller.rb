require 'slugify'

class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find_by(title_url: params[:title_url])
    render json: @post
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post[:title_url] = post_params[:title].slugify
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    @post[:title_url] = post_params[:title].slugify
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:id, :title, :title_url, :body, :subheading, :user_id)
  end
end
