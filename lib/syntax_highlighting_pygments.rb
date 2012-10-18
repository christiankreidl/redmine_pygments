require 'redmine/syntax_highlighting'

module Redmine
  module SyntaxHighlighting
    module Pygments
      require 'pygments'

      class << self
        def highlight_by_filename(text, filename)
          opts = {:filename => filename, :options => {:encoding => 'utf-8', :nowrap => true}}
          begin
            ::Pygments.highlight(text, opts)
          rescue
            ERB::Util.h(text)
          end
        end

        def highlight_by_language(text, language)
          opts = {:options => {:encoding => 'utf-8', :linenos => 'inline'}}
          lexer = ::Pygments::Lexer.find(language)
          opts[:lexer] = lexer[:aliases].first if lexer
          begin
            ::Pygments.highlight(text, opts).
              sub(%r{\A(<div class="highlight">)<pre>\n*}, '\1').
              sub(%r{\n*</pre>(</div>)\Z}, '\1')
          rescue
            ERB::Util.h(text)
          end
        end
      end
    end
  end

  SyntaxHighlighting.highlighter = 'Pygments'
end
