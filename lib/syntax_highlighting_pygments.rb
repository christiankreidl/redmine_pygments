require 'redmine/syntax_highlighting'

module Redmine
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          begin
            lexer = ::Pygments.lexer_name_for(:filename => filename)
            highlight_by_lexer(text, lexer)
          rescue
            ERB::Util.h(text)
          end
        end

        def highlight_by_language(text, language)
          begin
            lexer = ::Pygments::Lexer.find(language)
            highlight_by_lexer(text, (lexer[:aliases].first if lexer))
          rescue
            ERB::Util.h(text)
          end
        end

        private

        def highlight_by_lexer(text, lexer)
          opts = {:options => {:encoding => 'utf-8', :nowrap => true}}
          opts[:lexer] = lexer if lexer
          ::Pygments.highlight(text, opts)
        end
      end
    end
  end

  SyntaxHighlighting.highlighter = 'Pygments'
end
