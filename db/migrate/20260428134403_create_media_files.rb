class CreateMediaFiles < ActiveRecord::Migration[8.1]
  def change
    create_table :media_files do |t|
      t.references :mediable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
