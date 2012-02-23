CrowdblogCore::Engine.routes.draw do

  devise_for :users, class_name: 'CrowdblogCore::User',
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :authors, only: :index

  resources :posts do
    resources :assets
  end

  root to: 'posts#index'

end
