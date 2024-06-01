class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: Settings.image_resize_to_limit
  end

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_max_length }
  validates :image, content_type: { in: Settings.allowed_image_content_types, message: I18n.t("micropost.mess") },
    size: { less_than: Settings.image_max_size_mb.megabytes, message: I18n.t("micropost.mess1") }

  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_user_or_followed_users, -> (user_id) {
    following_ids = Relationship.select(:followed_id).where(follower_id: user_id)
    where("user_id IN (#{following_ids.to_sql}) OR user_id = :user_id", user_id: user_id)
  }
end
