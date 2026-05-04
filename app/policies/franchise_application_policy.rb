class FranchiseApplicationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.super_admin?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    user.super_admin?
  end

  def show?
    user.super_admin?
  end

  def update?
    user.super_admin?
  end
end
