class VegetablesController < ApplicationController
  def index
    @vegetables = Vegetable.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @steps = @vegetable.growing_steps.order(:step_number)
  end
end
