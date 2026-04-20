class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :post_type
      t.references :campus, null: false, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
