class StepProgressesController < ApplicationController
  before_action :authenticate_user!

  def create
    progress = StepProgress.find_or_initialize_by(
    user: current_user,
    growing_step_id: params[:growing_step_id]
  )

  progress.checked = ActiveModel::Type::Boolean.new.cast(params[:checked])

  if progress.save
    head :ok
  else
    head :unprocessable_entity
  end
 end
end