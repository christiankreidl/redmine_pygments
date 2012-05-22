module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename).sub(/^<div class="/, '\&line-code ')
        end

        def highlight_by_language(text, language)
          ::Pygments.highlight(text, :lexer => language).sub(/^<div class="/, '\&line-code ')
        end
      end
    end
  end
end
