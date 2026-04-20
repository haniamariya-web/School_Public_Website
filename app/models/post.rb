class Post < ApplicationRecord
  belongs_to :campus, class_name: "Campu", optional: true
  has_many :album_posts
  has_many :albums, through: :album_posts
  
  enum :post_type, { text: 0, image: 1, video: 2 }
end
