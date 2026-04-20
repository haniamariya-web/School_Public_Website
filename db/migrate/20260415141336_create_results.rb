class CreateResults < ActiveRecord::Migration[8.1]
  def change
    create_table :results do |t|
      t.string :student_name
      t.string :roll_number
      t.string :level
      t.integer :obtained_marks
      t.integer :total_marks
      t.string :grade
      t.string :academic_year
      t.references :campus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
