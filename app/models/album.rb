class Album < ApplicationRecord
  belongs_to :campus
  has_many :posts, through: :album_posts
end
