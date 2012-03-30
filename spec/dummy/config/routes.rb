Rails.application.routes.draw do

  mount Crowdblog::Engine => '/admin'

  devise_for :users

  devise_scope :user do
    match 'user_sign_in', to: 'devise/sessions#new'
  end

  root to: 'home#show'

end
