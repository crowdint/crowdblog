Rails.application.routes.draw do

  mount Crowdblog::Engine => '/admin'

  root to: 'home#show'

end
