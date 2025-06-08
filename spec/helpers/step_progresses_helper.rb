module StepProgressesHelper
  def user_checked_step?(step)
    return false unless user_signed_in?

    current_user.step_progresses.exists?(growing_step_id: step.id)
  end
end
