module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename)
        end

        def highlight_by_language(text, language)
          ::Pygments.highlight(text, :lexer => language)
        end
    end
  end
end
