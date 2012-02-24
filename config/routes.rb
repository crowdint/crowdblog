Crowdblog::Engine.routes.draw do

  devise_for :users, class_name: 'Crowdblog::User'

  resources :authors, only: :index

  resources :posts do
    resources :assets
  end

  root to: 'posts#index'

end
