Crowdblog::Engine.routes.draw do

  resources :authors, only: :index

  resources :posts do
    resources :assets
  end

  root to: 'posts#index'

  devise_for :users, :class_name => 'Crowdblog::User', :module => 'crowdblog/devise'
end
