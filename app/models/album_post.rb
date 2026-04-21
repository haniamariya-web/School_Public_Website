class AlbumPost < ApplicationRecord
  belongs_to :album
  belongs_to :post
  
  validates :display_order, uniqueness: { scope: :album_id }, allow_nil: true
end
