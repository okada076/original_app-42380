class VegetablesController < ApplicationController
  def index
    @vegetables = Vegetable.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @steps = @vegetable.growing_steps.order(:step_number)

    @progresses = if user_signed_in?
                    StepProgress.where(user: current_user, growing_step_id: @steps.pluck(:id)).index_by(&:growing_step_id)
                  else
                    {}
                  end
  end
end
