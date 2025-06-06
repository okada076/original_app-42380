class GrowingStep < ApplicationRecord
  belongs_to :vegetable

  validates :title, :content, :step_number, presence: true
end
