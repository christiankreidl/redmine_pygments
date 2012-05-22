Redmine::Plugin.register :redmine_pygments do
  name 'Redmine Pygments plugin'
  author 'ichizok'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end

require 'syntax_highlighting_pygments'
require 'pygments_stylesheet_hook'

Redmine::SyntaxHighlighting.highlighter = RedminePygments::SyntaxHighlighting::Pygments
