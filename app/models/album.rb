class Album < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
  has_many :posts, through: :album_posts
end
