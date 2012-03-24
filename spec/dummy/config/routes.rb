Rails.application.routes.draw do

  mount Crowdblog::Engine => '/admin'

  devise_for :users

  root to: 'home#show'

end
