module Crowdblog
  class Engine < ::Rails::Engine
    isolate_namespace Crowdblog

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( crowdblog.css crowdblog.js )
    end
  end
end
