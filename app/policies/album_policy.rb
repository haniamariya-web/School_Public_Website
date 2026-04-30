# app/policies/album_policy.rb
class AlbumPolicy < ApplicationPolicy
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
    user.super_admin?  # Only super_admin can delete
  end
end