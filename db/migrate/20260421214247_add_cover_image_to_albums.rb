class AddCoverImageToAlbums < ActiveRecord::Migration[8.1]
  def change
    add_column :albums, :cover_image, :string
  end
end