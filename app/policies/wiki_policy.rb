class WikiPolicy < ApplicationPolicy
  def create?
    user.admin? || user.premium?
    end

  def destroy?
    user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        Wiki.all
      elsif user.premium?
        Wiki.all
      else
        Wiki.where(private: false)
      end
    end
  end
end
