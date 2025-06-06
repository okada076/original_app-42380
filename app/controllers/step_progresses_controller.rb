class StepProgressesController < ApplicationController
  before_action :authenticate_user!

  def create
    progress = StepProgress.find_or_initialize_by(
      user: current_user,
      growing_step_id: params[:growing_step_id]
    )
    progress.checked = params[:checked] == '1'
    progress.save
    redirect_back fallback_location: root_path
  end
end
