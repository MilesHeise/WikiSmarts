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
      wikis = []
      if user.nil?
        wikis = scope.where(private: false)
      elsif user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user_id == user.id || wiki.collab_users.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          wikis << wiki if !wiki.private? || wiki.collab_users.include?(user)
        end
      end
      wikis
    end
  end
end
