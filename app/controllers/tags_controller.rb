class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user, :vegetable).order(created_at: :desc)
  end
end
