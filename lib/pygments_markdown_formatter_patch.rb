module PygmentsMarkdownFormatterPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      alias_method_chain :block_code, :pygments
    end
  end

  def block_code_with_pygments(code, language)
    if language != nil
      '<div class="autoscroll">' \
      + Redmine::SyntaxHighlighting.highlight_by_language(code, language) \
      + '</div>'
    else
      "<pre>\n" + CGI.escapeHTML(code) + "</pre>"
    end
  end
end
