module ApplicationHelper
  def markdown(text)
    options = {
      escape_html:     true,
      hard_wrap:       true
    }

    extensions = {
      no_intra_emphasis: true,
      strikethrough: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
