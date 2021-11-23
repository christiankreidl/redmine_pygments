module PygmentsApplicationHelperPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      prepend InstanceMethods
    end
  end

  module InstanceMethods

  def syntax_highlight_lines(name, content)
    lines = []
    syntax_highlight(name, content).each_line {|line| lines << "<div class=\"highlight\">#{line}</div>"}
    lines
  end

  end
end
