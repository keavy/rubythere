Rubythere::Application.routes.draw do
  namespace :admin do |admin|
    resources :events do
      resources :happenings
      collection do
        delete :delete_group
      end
    end
    resource :user_session
    resources :presentations
  end
  match 'admin', :to => 'admin#events', :as => 'admin'

  match 'events/to/:focus', :to => 'events#index', :as => 'events_to'

  resources :events do
    resources :happenings
  end

  resources :feeds, :happenings
  resource :archive, :contact, :account, :search, :calendar, :map

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  root :to => "home#index"
end
