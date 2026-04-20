class CreateAlbumPosts < ActiveRecord::Migration[8.1]
  def change
    create_table :album_posts do |t|
      t.references :album, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :display_order

      t.timestamps
    end
  end
end
