
Rails.configuration.to_prepare do
  require_dependency 'application_helper'
  ApplicationHelper.send(:include, PygmentsApplicationHelperPatch)

  require_dependency 'redmine/wiki_formatting/textile/formatter'
  Redmine::WikiFormatting::Textile::Formatter.send(:include, PygmentsTextileFormatterPatch)

  if Redmine::VERSION::MAJOR > 2 || (Redmine::VERSION::MAJOR == 2 && Redmine::VERSION::MINOR >= 5)
    require_dependency 'redmine/wiki_formatting/markdown/formatter'
    Redmine::WikiFormatting::Markdown::HTML.send(:include, PygmentsMarkdownFormatterPatch)
  end
end

Redmine::Plugin.register :redmine_pygments do
  name 'Redmine Pygments plugin'
  author 'ichizok, Christian Kreidl'
  description 'Syntax-highlighter powered by Pygments'
  version '0.3.1'
  url 'https://github.com/christiankreidl/redmine_pygments'
  author_url 'https://bitbucket.org/ichizok'
  requires_redmine :version_or_higher => '4.0'
end

class PygmentsStylesheetHook < Redmine::Hook::ViewListener
  render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag 'highlight', :plugin => 'redmine_pygments' %>"
end
