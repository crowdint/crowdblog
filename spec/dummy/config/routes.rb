Rails.application.routes.draw do

  mount CrowdblogCore::Engine => '/admin'

  root to: 'crowdblog_core/posts#index'
end
