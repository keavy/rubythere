ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :events
    admin.resource :user_session
  end
  map.admin 'admin', :controller => 'admin/events'
  
  map.events_to 'events/to/:focus', :controller => 'happenings', :action => 'index'
  map.resources :events
  map.resources :happenings, :collection => {:archive => :get}
  
  map.root :controller => "home"
end
