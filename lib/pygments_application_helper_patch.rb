module PygmentsApplicationHelperPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      alias_method_chain :syntax_highlight_lines, :pygments
    end
  end

  def syntax_highlight_lines_with_pygments(name, content)
    lines = []
    syntax_highlight(name, content).each_line {|line| lines << "<div class=\"highlight\">#{line}</div>"}
    lines
  end
end
