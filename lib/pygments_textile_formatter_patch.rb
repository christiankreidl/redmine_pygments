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
          num = $2
          content = @pre_list[$2.to_i]
          if content.match(%r{<code\s+class="([-\w]+)">\s?(.+)}m)
            hltext = Redmine::SyntaxHighlighting.highlight_by_language($2, $1)
            content = hltext.sub(%r{(?:<pre>)([\s\d]+)(?=</pre>)}) do |nos|
              nos.gsub(%r{ *(\d+)}, %{<span id="C#{num}-L\\1" rel="#C#{num}-L\\1">\\&</span>})
            end
            content += '>' unless content[-1] == '>' # pygments.rb bug?
            content = '<div class="autoscroll">' + content + '</div>'
          else
            content = "<pre>" + content + "</code></pre>"
          end
        else
          content = @pre_list[$1.to_i] + "</pre>"
        end
        content
      end
    end
  end
end
