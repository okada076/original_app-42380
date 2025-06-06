class GrowingStep < ApplicationRecord
  belongs_to :vegetable
  has_many :step_progresses
  has_many :users_checked, through: :step_progresses, source: :user

  validates :title, :content, :step_number, presence: true
end
