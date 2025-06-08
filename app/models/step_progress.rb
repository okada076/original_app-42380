class StepProgress < ApplicationRecord
  belongs_to :user
  belongs_to :growing_step
end
