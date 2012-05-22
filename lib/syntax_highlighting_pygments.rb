module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename).gsub(@@tags, '')
        end

        def highlight_by_language(text, language)
          ::Pygments.highlight(text, :lexer => language).gsub(@@tags, '')
        end

        private

        @@tags = /<\/?(div|pre)[^>]*>/
      end
    end
  end
end
