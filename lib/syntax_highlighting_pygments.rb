module RedminePygments
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          ::Pygments.highlight(text, :filename => filename, :options => {:encoding => 'utf-8', :nowrap => true})
        end

        def highlight_by_language(text, language)
          opts = {:options => {:encoding => 'utf-8', :nowrap => true}}
          opts[:lexer] = language if ::Pygments::Lexer.find(language)
          hltext = ::Pygments.highlight(text, opts)
          lines = []
          i = 0
          idx = "%##{hltext.count("\n").to_s.size}d"
          hltext.each_line do |line|
            lines << "<span class=\"line-numbers\">#{idx % (i += 1)}</span>#{line}"
          end
          "<div class=\"highlight\">#{lines.join.rstrip}</div>"
        end
      end
    end
  end
end
