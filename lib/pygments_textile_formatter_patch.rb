module PygmentsTextileFormatterPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      alias_method_chain :smooth_offtags, :pygments
    end
  end

  def smooth_offtags_with_pygments(text)
    unless @pre_list.empty?
      ## replace <pre> content
      text.gsub!(%r{<redpre#(\d+)>(?:\s*<redpre#(\d+)></code>\s*)?</pre>}) do
        if $2
          content = @pre_list[$2.to_i]
          if content.match(%r{<code\s+class="(\w+)">\s?(.+)}m)
            i = 0
            lines = [%{<div class="autoscroll"><table class="embedded-code #{$1} syntaxhl"><tbody>\n}]
            hltext = Redmine::SyntaxHighlighting.highlight_by_language($2, $1)
            hltext.each_line do |line|
              i += 1
              lines << %{<tr>\n<th class="line-num" id="L#{i}"><a href="#L#{i}">#{i}</a></th>\n}
              lines << %{<td class="line-code"><pre><div class="highlight">#{line}</div></pre></td>\n</tr>\n}
            end
            lines << %{</tbody></table></div>\n}
            content = lines.join('')
          end
        else
          content = @pre_list[$1.to_i] + "</pre>"
        end
        content
      end
    end
  end
end
