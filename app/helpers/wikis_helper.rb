module WikisHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
   end

  def wiki_owner?(wiki)
    current_user && current_user.id == wiki.user_id
  end
end
