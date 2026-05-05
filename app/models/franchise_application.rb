class FranchiseApplication < ApplicationRecord
  FRANCHISE_FEE = 50000  # $500 in cents

  has_one :franchise_payment
  has_many :franchise_documents

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 255 }
  validates :phone, presence: true,
                    format: { with: /\A\+?[\d\s\-()]{7,20}\z/, message: "must be a valid phone number" },
                    length: { maximum: 20 }
  validates :address, presence: true, length: { maximum: 500 }
  validates :status, presence: true

  enum :status, {
    pending_payment: "pending_payment",
    payment_received: "payment_received",
    approved: "approved",
    rejected: "rejected"
  }

  before_validation :set_initial_status, on: :create

  private

  def set_initial_status
    self.status ||= "pending_payment"
  end
end
