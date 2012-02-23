Rails.application.routes.draw do

  mount CrowdblogCore::Engine => '/admin'
end
