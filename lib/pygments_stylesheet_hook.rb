module RedminePygments
  module PygmentsStylesheetHook < Redmine::Hook::ViewListener
    render_on :view_layouts_base_html_head, :inline => "<%= stylesheet_link_tag 'highlight', :plugin => 'redmine_pygments' %>"
  end
end
