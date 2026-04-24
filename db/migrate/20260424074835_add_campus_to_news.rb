class AddCampusToNews < ActiveRecord::Migration[8.1]
  def change
    add_reference :news, :campus, null: true, foreign_key: true
  end
end
