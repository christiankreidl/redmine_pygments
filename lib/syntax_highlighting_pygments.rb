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
          lines = []
          content.each_line { |line| lines << line }
          index = "%##{lines.size.to_s.size}d"
          lines.each_with_index { |line, i|
            lines[i] = "<span class=\"line-numbers\">#{index % (i + 1)}</span>#{line}"
          }
          "<div class=\"highlight\">#{lines.join}</div>"
        end
      end
    end
  end
end
