Rails.application.routes.draw do

  mount CrowdblogCore::Engine => "/crowdblog_core"
end
