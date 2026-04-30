class CreateFranchisePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :franchise_payments do |t|
      t.integer :franchise_application_id
      t.string :stripe_payment_intent_id
      t.integer :amount
      t.string :status
      t.string :receipt_url
      t.string :card_last4
      t.datetime :paid_at

      t.timestamps
    end
  end
end
