class AddIndexesToFranchiseTables < ActiveRecord::Migration[8.1]
  def change
    add_index :franchise_applications, :stripe_payment_intent_id
    add_index :franchise_payments, :stripe_payment_intent_id
    add_foreign_key :franchise_payments, :franchise_applications
  end
end
