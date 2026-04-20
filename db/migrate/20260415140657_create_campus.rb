class CreateCampus < ActiveRecord::Migration[8.1]
  def change
    create_table :campus do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :principal_name

      t.timestamps
    end
  end
end
