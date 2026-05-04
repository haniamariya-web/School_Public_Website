class News < ApplicationRecord
  belongs_to :campus, class_name: "Campu", optional: true
  before_save :set_published_at

  # Polymorphic relationship
  has_one :media_file, as: :mediable, dependent: :destroy
  accepts_nested_attributes_for :media_file, allow_destroy: true

  validates :title, :content, presence: true

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
