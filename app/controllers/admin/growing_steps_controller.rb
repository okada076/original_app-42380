class Admin::GrowingStepsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def new
    @growing_step = GrowingStep.new
    @vegetables = Vegetable.all
  end

  def create
     @growing_step = GrowingStep.new(growing_step_params)
    if @growing_step.save
      redirect_to new_admin_growing_step_path, notice: "育て方手順を追加しました！"
    else
      @vegetables = Vegetable.all
      render :new
    end
  end

  private

  def growing_step_params
    params.require(:growing_step).permit(:vegetable_id, :step_number, :title, :content)
  end

  def ensure_admin!
    unless current_user.email == "あなたのメールアドレス"
      redirect_to root_path, alert: "アクセス権限がありません"
    end
  end
end
