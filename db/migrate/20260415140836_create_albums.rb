class CreateAlbums < ActiveRecord::Migration[8.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.references :campus, null: false, foreign_key: true
      t.date :event_date

      t.timestamps
    end
  end
end
