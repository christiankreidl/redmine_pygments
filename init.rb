require 'redmine'

require 'pygments_stylesheet_hook'
require 'syntax_highlighting_pygments'

Rails.configuration.to_prepare do
  require_dependency 'application_helper'
  ApplicationHelper.send(:include, PygmentsApplicationHelperPatch)

  require_dependency 'redmine/wiki_formatting/textile/formatter'
  Redmine::WikiFormatting::Textile::Formatter.send(:include, PygmentsTextileFormatterPatch)
end

Redmine::Plugin.register :redmine_pygments do
  name 'Redmine Pygments plugin'
  author 'ichizok'
  description 'Syntax-highlighter powered by Pygments'
  version '0.1.2'
  url 'https://bitbucket.org/ichizok/redmine_pygments'
  author_url 'https://bitbucket.org/ichizok'
  requires_redmine :version_or_higher => '2.0.0'
end
