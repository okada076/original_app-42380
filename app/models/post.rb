class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :vegetable, optional: true

  enum category: { grow_log: 0, trouble_note: 1 }

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :image, presence: true
  validates :vegetable_id, presence: true

  private

  def image_presence
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
