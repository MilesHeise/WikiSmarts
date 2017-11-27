class WikiPolicy < ApplicationPolicy
  def create?
    user.admin?
    end

  def destroy?
    user.admin?
  end

  class Scope
    def resolve
      if user.admin?
        Wiki.all
      elsif user.premium?

      else
        Wiki.where(private: false)
      end
    end
  end
end
