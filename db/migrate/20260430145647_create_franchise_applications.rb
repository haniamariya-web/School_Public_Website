class CreateFranchiseApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :franchise_applications do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.string :status
      t.string :stripe_payment_intent_id

      t.timestamps
    end
  end
end
