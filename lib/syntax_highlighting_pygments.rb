module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename, :options => {:nowrap => true})
        end

        def highlight_by_language(text, language)
          content = ::Pygments.highlight(text, :lexer => language, :options => {:nowrap => true})
          "<div class=\"highlight\">#{content}</div>"
        end
      end
    end
  end
end
