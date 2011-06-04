Rubythere::Application.routes.draw do
  namespace :admin do |admin|
    resources :events do
      resources :happenings
    end
    resource :user_session
    resources :presentations
  end
  match 'admin', :to => 'admin#events', :as => 'admin'

  match 'events/to/:focus', :to => 'events#index', :as => 'events_to'

  resources :events do
    resources :happenings
  end

  match 'map', :to => 'happenings#map', :as => 'map'

  resources :feeds, :happenings
  resource :archive, :contact, :account, :search, :calendar

  resource :session
  get 'sessions/callback', :to => 'sessions#callback', :as => 'callback'
  match 'logout', :to => 'sessions#destroy', :as => 'logout'
  match 'login', :to => 'sessions#new', :as => 'login'

  root :to => "home#index"
end
