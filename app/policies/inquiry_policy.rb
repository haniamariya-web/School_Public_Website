# app/policies/inquiry_policy.rb
class InquiryPolicy < ApplicationPolicy
  def index?
    user.super_admin? || user.campus_manager?
  end
  
  def show?
    user.super_admin? || user.campus_manager?
  end
  
  def mark_contacted?
    user.super_admin? || user.campus_manager?
  end
  
  class Scope < Scope
    def resolve
      if user.super_admin? || user.campus_manager?
        scope.all
      else
        scope.none
      end
    end
  end
end