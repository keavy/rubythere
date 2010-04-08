ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :events
    admin.resource :user_session
    admin.resources :presentations
  end
  map.admin 'admin', :controller => 'admin/events'
  
  map.events_to 'events/to/:focus.:format', :controller => 'happenings', :action => 'index'
  
  map.resources :events, :feeds
  map.resources :happenings, :collection => {:archive => :get}
  map.resource :archive, :contact
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.root :controller => "home"
end
