class AlbumPost < ApplicationRecord
  belongs_to :album
  belongs_to :post
end
