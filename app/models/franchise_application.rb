class FranchiseApplication < ApplicationRecord
  FRANCHISE_FEE = 50000  # $500 in cents
  
  has_one :franchise_payment
  has_many :franchise_documents
  
  validates :name, :email, :phone, :address, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
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