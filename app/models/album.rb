class Album < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
  has_many :album_posts, dependent: :destroy
  has_many :posts, through: :album_posts
  
  # Active Storage for cover image
  has_one_attached :cover_image
  
  validates :title, presence: true
  
  scope :recent, -> { order(event_date: :desc) }
  
  def cover_or_fallback_url
    if cover_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(cover_image, only_path: true)
    else
      first_post_image = posts.includes(image_attachment: :blob).find do |post|
        post.image.attached?
      end
    
      if first_post_image
        Rails.application.routes.url_helpers.rails_blob_url(first_post_image.image, only_path: true)
      else
        nil
      end
    end
  end
end
