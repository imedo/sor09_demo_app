ActionController::Routing::Routes.draw do |map|
  # These are commented out, because they dispatch requests to the other applications.
  
  # map.connect 'blog_entries/*params', :controller => 'apps', :action => 'dispatch', :app => 'blog', :app_controller => 'blog_entries'
  # map.connect 'comments/*params', :controller => 'apps', :action => 'dispatch', :app => 'comments', :app_controller => 'comments'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
