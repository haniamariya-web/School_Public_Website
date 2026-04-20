class CreateInquiries < ActiveRecord::Migration[8.1]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :grade_level
      t.integer :preferred_call_time
      t.text :message
      t.integer :status

      t.timestamps
    end
  end
end
