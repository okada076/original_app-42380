class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def new
    @post = Post.new
    @vegetables = Vegetable.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      @vegetables = Vegetable.all
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :image, :vegetable_id)
  end
end
