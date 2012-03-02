Crowdblog::Engine.routes.draw do

  resources :authors, only: :index

  resources :posts do
    resources :assets
  end

  root to: 'posts#index'

end
