# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def show?
    true
  end
  
  def new?
    create?
  end
  
  def create?
    user.super_admin? || user.campus_manager?
  end
  
  def edit?
    update?
  end
  
  def update?
    user.super_admin? || user.campus_manager?
  end
  
  def destroy?
    user.super_admin?
  end
  
  def remove_media?
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