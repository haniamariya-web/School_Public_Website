class News < ApplicationRecord
  # Active Storage
  has_one_attached :image
  has_one_attached :video

  belongs_to :campus, class_name: 'Campu', optional: true
  
  validates :title, presence: true, length: { minimum: 5, maximum:  100}
  validates :content, presence: true, length: { minimum: 10, maximum: 10_000 }
  before_create :set_published_at

  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :recent, -> { order(published_at: :desc).limit(5) }
  
  def has_media?
    image.attached? || video.attached?
  end

  private
  def set_published_at
    self.published_at ||= Time.current
  end
end