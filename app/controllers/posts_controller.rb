class PostsController < ApplicationController
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
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category, :image, :vegetable_id)
  end
end
