class GrowingStepsController < ApplicationController
  before_action :authenticate_user!
  def index
    @vegetable = Vegetable.find(params[:vegetable_id])
    @growing_steps = @vegetable.growing_steps.order(:step_number)
  end
end
