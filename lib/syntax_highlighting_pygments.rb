module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename, :options => {:nowrap => true})
        end

        def highlight_by_language(text, language)
          opts = {:options => {:nowrap => true}}
          opts[:lexer] = language if ::Pygments::Lexer.find(language)
          content = ::Pygments.highlight(text, opts)
          lines = []
          i = 0
          index = "%##{(content.count("\n") + (/[^\n]\z/ =~ content ? 1 : 0)).to_s.size}d"
          content.each_line { |line|
            lines << "<span class=\"line-numbers\">#{index % (i += 1)}</span>#{line}"
          }
          "<div class=\"highlight\">#{lines.join}</div>"
        end
      end
    end
  end
end
