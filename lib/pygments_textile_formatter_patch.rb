module PygmentsTextileFormatterPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      prepend InstanceMethods
    end
  end

  module InstanceMethods

  def smooth_offtags(text)
    unless @pre_list.empty?
      ## replace <pre> content
      text.gsub!(%r{<redpre#(\d+)>(?:\s*<redpre#(\d+)></code>\s*)?(</(?:\w+)>)}) do
        if $2
          num = $2
          content = @pre_list[$2.to_i]
          if content.match(%r{<code\s+class="([-\w]+)">\s?(.+)}m)
            hltext = Redmine::SyntaxHighlighting.highlight_by_language($2, $1)
            content = hltext.sub(%r{(?:<pre>)([\s\d]+)(?=</pre>)}) do |nos|
              nos.gsub(%r{ *(\d+)}, %{<span id="C#{num}-L\\1" rel="#C#{num}-L\\1">\\&</span>})
            end
            content = '<div class="autoscroll">' + content + '</div>'
          else
            content = "<pre>" + content + "</code></pre>"
          end
        else
          content = @pre_list[$1.to_i] + $3
        end
        content
      end
    end
  end

  end
end

