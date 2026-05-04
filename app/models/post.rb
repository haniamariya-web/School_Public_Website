class Post < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
  has_many :album_posts, dependent: :destroy
  has_many :albums, through: :album_posts

  # Polymorphic relationship
  has_one :media_file, as: :mediable, dependent: :destroy
  accepts_nested_attributes_for :media_file, allow_destroy: true

  validates :title, :campus, presence: true
  before_create :set_published_at

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

  private

  def set_published_at
    self.published_at ||= Time.current
  end
end
