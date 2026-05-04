# app/policies/news_policy.rb
class NewsPolicy < ApplicationPolicy
  def index?
    true  # Both roles can view index
  end

  def show?
    true  # Both roles can view
  end

  def new?
    create?
  end

  def create?
    user.super_admin?  # Only super_admin can create
  end

  def edit?
    update?
  end

  def update?
    user.super_admin?  # Only super_admin can edit
  end

  def destroy?
    user.super_admin?  # Only super_admin can delete
  end

  def remove_media?
    user.super_admin?  # Only super_admin can remove media
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
