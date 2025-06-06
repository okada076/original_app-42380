class Vegetable < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true
end
