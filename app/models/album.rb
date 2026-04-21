class Album < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
  has_many :album_posts, dependent: :destroy
  has_many :posts, through: :album_posts
  
  # Active Storage for cover image
  has_one_attached :cover_image
  
  validates :title, presence: true
  
  scope :recent, -> { order(event_date: :desc) }
  
  def cover_or_fallback
    return cover_image if cover_image.attached?
    
    # Find first post with attached image
    posts.each do |post|
      return post.image if post.image.attached?
    end
    
    nil
  end
end
