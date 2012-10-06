Rails.application.routes.draw do

  mount Crowdblog::Engine => '/blogadmin'

  root to: 'home#show'
end
