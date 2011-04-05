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
    collection do
      resources :happenings
    end
  end

  resources :feeds, :happenings
  resource :archive, :contact, :account, :search, :calendar

  resource :session
  match 'session/confirm', :to => 'sessions#confirm', :as => 'confirm_session'
  match 'logout', :to => 'sessions#destroy', :as => 'logout'
  match 'login', :to => 'sessions#new', :as => 'login'

  root :to => "home#index"
end
