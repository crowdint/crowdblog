Rails.application.routes.draw do

  mount Crowdblog::Engine => '/admin'

  root to: 'crowdblog/posts#index'
end
