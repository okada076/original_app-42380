class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
    @vegetables = Vegetable.all
  end

  def create
   @post = Post.new(post_params)
  @post.user = current_user

  if @post.save
    case @post.category
    when "grow_log"
      redirect_to grow_logs_path, notice: '投稿が完了しました'
    when "trouble_note"
      redirect_to troubles_path, notice: '投稿が完了しました'
    else
      redirect_to root_path, notice: '投稿が完了しました'
    end
  else
    @vegetables = Vegetable.all
    render :new
    end
  end

  def index
    @posts = Post.includes(:user, :vegetable, :tags)

    # カテゴリ別に絞り込み
    case params[:filter]
    when 'failure'
      @posts = @posts.where(category: 'trouble_note')
    when 'mine'
      @posts = @posts.where(user_id: current_user.id) if user_signed_in?
    else
      @posts = @posts.where(category: 'grow_log')
    end

    # タグ検索（カテゴリと併用可能）
    @posts = @posts.joins(:tags).where(tags: { name: params[:tag] }).distinct if params[:tag].present?

    @posts = @posts.order(created_at: :desc)

    @vegetables = Vegetable.order(:name)
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @vegetables = Vegetable.all
    @post = Post.find(params[:id])
    @post.tag_names = @post.tags.pluck(:name).join(', ')
  end

  def update
    @vegetables = Vegetable.all

    @post.image.purge if params[:remove_image] == '1' && @post.image.attached?

    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    if @post.category == 'grow_log'
      redirect_to grow_logs_path, notice: '育成記録を削除しました。'
    else
      redirect_to troubles_path, notice: 'つまずきノートを削除しました。'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :image, :vegetable_id, :tag_names)
  end

  def redirect_unless_owner
    return if current_user == @post.user

    redirect_to grow_logs_path, alert: '不正なアクセスです。'
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
