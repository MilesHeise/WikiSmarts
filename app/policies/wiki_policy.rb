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
        Wiki.where(private: false) && Wiki.where('user_id = ?', params[:user.id])
        # beautify keeps changing double quotes to single, will that break this?
      else
        Wiki.where(private: false)
      end
    end
  end
end

# make it so users can create? and destroy if associated with them?
# change my views for privacy stuff
# verify can't see private when not signed in. check why could see private when not author
# despite scope thing?

# can I even create, currently, when not an admin?
# change form view so you only see checkbox if unchecked and premium, or
# checked and premium and yours?
