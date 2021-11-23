module PygmentsMarkdownFormatterPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      prepend InstanceMethods
    end
  end

  module InstanceMethods

  def block_code(code, language)
    if language != nil
      '<div class="autoscroll">' \
      + Redmine::SyntaxHighlighting.highlight_by_language(code, language) \
      + '</div>'
    else
      "<pre>\n" + CGI.escapeHTML(code) + "</pre>"
    end
  end

  end
end
