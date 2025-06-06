class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.includes(:user, :vegetable)

    case params[:filter]
    when 'grow_log'
      @posts = @posts.where(category: 'grow_log')
    when 'failure'
      @posts = @posts.where(category: 'trouble_note')
    end

    @posts = @posts.order(created_at: :desc)
  end
end
