ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :events
  end
  map.admin 'admin', :controller => 'admin/events'
  
  map.events_to 'events/to/:focus', :controller => 'events', :action => 'index'
  map.resources :events, :collection => {:archive => :get}
  
  map.root :controller => "home"
end
