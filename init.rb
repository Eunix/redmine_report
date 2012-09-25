# Patches to the Redmine core
require_dependency 'issue_patch'

Redmine::Plugin.register :redmine_report do
  name 'Redmine Report plugin'
  author 'Evgeny Pavlov'
  description 'Internal Report plugin for Redmine'
  version '0.1'
  url 'https://github.com/Eunix/redmine_report'
  author_url 'https://github.com/Eunix'

  menu :application_menu, :redmine_report, { :controller => 'time_reports', :action => 'index' }, :caption => 'Time Reports'
end
