class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :vegetable, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

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
