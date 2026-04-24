class News < ApplicationRecord
  # Active Storage
  has_one_attached :image
  has_one_attached :video
  
  validates :title, presence: true
  
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :recent, -> { order(published_at: :desc).limit(5) }
  
  def has_media?
    image.attached? || video.attached?
  end
end