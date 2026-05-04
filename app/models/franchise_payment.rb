class FranchisePayment < ApplicationRecord
  belongs_to :franchise_application

  validates :stripe_payment_intent_id, :amount, :status, presence: true
  validates :amount, numericality: { greater_than: 0 }

  enum :status, {
    succeeded: "succeeded",
    failed: "failed",
    refunded: "refunded"
  }

  after_save :update_franchise_application_status

  private

  def update_franchise_application_status
    if succeeded?
      franchise_application.update(status: "payment_received")
    end
  end
end
