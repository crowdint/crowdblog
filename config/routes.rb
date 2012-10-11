Crowdblog::Engine.routes.draw do
  root :to => 'posts#index'

  namespace :admin do
    resources :authors, only: :index

    match 'posts/:state', :to => 'posts#index',
      :constraints => { :state => /(published|drafted)/ },
      :as => 'posts_by_state',
      :via => :get

    resources :posts do
      resources :assets
    end

    root :to => 'posts#index'
  end

  devise_for :users, :class_name => 'Crowdblog::User',
      :module => 'crowdblog/devise'
end
