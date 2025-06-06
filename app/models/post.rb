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

  validates :title, :content, :category, :image, :vegetable_id, presence: true

  attr_accessor :tag_names

  after_save :save_tags

  def save_tags
    return if tag_names.nil?

    # タグの更新をトランザクション内で安全に処理
    PostTag.transaction do
      post_tags.destroy_all
      tag_names.split(',').map(&:strip).reject(&:blank?).each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        tags << tag unless tags.include?(tag)
      end
    end
  end
end
