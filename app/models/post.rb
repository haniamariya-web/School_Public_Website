class Post < ApplicationRecord
  belongs_to :campus
  enum :post_type, { text: 0, image: 1, video: 2 }
end
