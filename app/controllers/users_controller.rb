class UsersController < ApplicationController
  before_action :authenticate_user!

  def liked_posts
    @user = current_user
    @liked_posts = @user.liked_posts.includes(:vegetable, :user)
  end
end
