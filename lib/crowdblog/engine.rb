module Crowdblog
  class Engine < ::Rails::Engine
    isolate_namespace Crowdblog

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
