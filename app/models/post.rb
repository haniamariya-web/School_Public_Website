class Post < ApplicationRecord
  belongs_to :campus, class_name: "Campu", optional: true
  has_many :album_posts, dependent: :destroy
  has_many :albums, through: :album_posts
  
  # Active Storage
  has_one_attached :image
  has_one_attached :video
  
  validates :title, presence: true
  
  # Helper methods
  def has_media?
    image.attached? || video.attached?
  end
  
  def media_type
    return :image if image.attached?
    return :video if video.attached?
    :none
  end
  
  def display_media
    return image if image.attached?
    return video if video.attached?
    nil
  end
end
