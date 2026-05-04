# app/models/admin_user.rb
class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  ROLES = %w[super_admin campus_manager].freeze

  def super_admin?
    role == "super_admin"
  end

  def campus_manager?
    role == "campus_manager"
  end
end
