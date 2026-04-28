class Post < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
  has_many :album_posts, dependent: :destroy
  has_many :albums, through: :album_posts
  
  # Single media attachment
  has_one_attached :media
  
  MAX_MEDIA_SIZE = 1.megabyte
  
  validates :title, presence: true
  validates :campus, presence: true
  validate :validate_media_type
  validate :validate_media_size
  
  before_create :set_published_at
  
  def media_type
    return nil unless media.attached?
    
    if media.content_type.start_with?('image/')
      :image
    elsif media.content_type.start_with?('video/')
      :video
    else
      :unknown
    end
  end
  
  def has_media?
    media.attached?
  end
  
  private
  
  def validate_media_type
    if media.attached?
      unless media.content_type.start_with?('image/', 'video/')
        errors.add(:media, "must be an image or video")
      end
    end
  end

  def validate_media_size
    return unless media.attached?

    if media.blob.byte_size > MAX_MEDIA_SIZE
      errors.add(:media, "must be smaller than #{MAX_MEDIA_SIZE / 1.megabyte} MB")
    end
  end
  
  def set_published_at
    self.published_at ||= Time.current
  end
end