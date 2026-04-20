class Inquiry < ApplicationRecord
  enum :preferred_call_time, { morning: 0, afternoon: 1, evening: 2 }
  enum :status, { pending: 0, contacted: 1, closed: 2 }
  
  validates :name, :email, :phone, :grade_level, :preferred_call_time, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, length: { minimum: 10 }
end