module ApplicationHelper
  def premium_author?(wiki)
    current_user.role == :premium && current_user == wiki.user
  end
end
