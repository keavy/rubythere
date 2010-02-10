ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :events
  end
  map.admin 'admin', :controller => 'admin/events'
  
  map.root :controller => "home"
end
