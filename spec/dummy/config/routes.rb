Rails.application.routes.draw do

  resource :home, only: :show, controller: :home

  mount Crowdblog::Engine => '/admin'

  devise_for :users

  root to: 'home#show'

end
