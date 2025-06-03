class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]
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
    @posts = Post.includes(:user, :vegetable)

    case params[:filter]
    when 'failure'
      @posts = @posts.where(category: 'つまずきノート')
    when 'mine'
      @posts = @posts.where(user_id: current_user.id) if user_signed_in?
    else
      @posts = @posts.where(category: 'grow_log')
    end

    @posts = @posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @vegetables = Vegetable.all
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :image, :vegetable_id)
  end

  def redirect_unless_owner
    @post = Post.find(params[:id])
    redirect_to posts_path, alert: '不正なアクセスです。' unless current_user == @post.user
  end
end
