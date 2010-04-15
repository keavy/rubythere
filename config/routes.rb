ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :events
    admin.resource :user_session
    admin.resources :presentations
  end
  map.admin 'admin', :controller => 'admin/events'
  
  map.events_to 'events/to/:focus.:format', :controller => 'events', :action => 'index'
  
  map.resources :events, :has_many => [:happenings]
  map.resources :feeds
  map.resource :archive, :contact, :account
  map.register '/register', :controller => 'users', :action => 'new'
  
  map.resource :session
  map.confirm_session 'session/confirm', :controller => 'sessions', :action => 'confirm'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  
  map.root :controller => "home"
end
