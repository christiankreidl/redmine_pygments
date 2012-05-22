module PygmentsApplicationHelperPatch
  extend ActiveSupport::Concern

  included do
    class_eval do
      alias_method_chain :syntax_highlight, :pygments
    end
  end

  def syntax_highligh_with_pygments(name, content)
    @code_css = 'line-code highlight'
    syntax_highligh_with_pygments(name, content)
  end

end
