require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      inquiry = Inquiry.new(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '1234567890',
        grade_level: 'Grade 10',
        preferred_call_time: :morning
      )
      expect(inquiry).to be_valid
    end

    it 'is invalid without a name' do
      inquiry = Inquiry.new(name: nil)
      inquiry.valid?
      expect(inquiry.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with an incorrect email format' do
      inquiry = Inquiry.new(email: 'invalid-email')
      inquiry.valid?
      expect(inquiry.errors[:email]).to include("is invalid")
    end

    it 'is invalid with a phone number that is too short' do
      inquiry = Inquiry.new(phone: '123')
      inquiry.valid?
      expect(inquiry.errors[:phone]).to include("is too short (minimum is 10 characters)")
    end
  end

  describe 'enums' do
    it 'defines preferred_call_time' do
      expect(Inquiry.preferred_call_times).to include('morning', 'afternoon', 'evening')
    end

    it 'defines status' do
      expect(Inquiry.statuses).to include('pending', 'contacted', 'closed')
    end
  end
end
