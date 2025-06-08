class Vegetable < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true
  has_many :growing_steps, dependent: :destroy
end
