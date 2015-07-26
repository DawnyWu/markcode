module ApplicationHelper

  def md_to_html md
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter
    ]
    result = pipeline.call(md)
    html = result[:output].to_s
    html
    # binding.pry
  end

  def render_markup(file_name, file_content)
    if gitlab_markdown?(file_name)
      Haml::Helpers.preserve(markdown(file_content))
    elsif asciidoc?(file_name)
      asciidoc(file_content)
    elsif plain?(file_name)
      content_tag :pre, class: 'plain-readme' do
        file_content
      end
    else
      GitHub::Markup.render(file_name, file_content).
        force_encoding(file_content.encoding).html_safe
    end
  rescue RuntimeError
    simple_format(file_content)
  end

  # def render_markup(file_name, file_content)
  #   if gitlab_markdown?(file_name)
  #     GitHub::Markup.render(file_name, file_content).
  #       force_encoding(file_content.encoding).html_safe
  #   elsif asciidoc?(file_name)
  #     asciidoc(file_content)
  #   elsif plain?(file_name)
  #     content_tag :pre, class: 'plain-readme' do
  #       file_content
  #     end
  #   end
  # rescue RuntimeError
  #   simple_format(file_content)
  # end

  def markup?(filename)
    Gitlab::MarkupHelper.markup?(filename)
  end

  def gitlab_markdown?(filename)
    Gitlab::MarkupHelper.gitlab_markdown?(filename)
  end

  def asciidoc?(filename)
    Gitlab::MarkupHelper.asciidoc?(filename)
  end
end
