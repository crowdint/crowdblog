require "crowdblog/engine"

require "carrierwave"
require "devise"
require "gravtastic"
require "redcarpet"
require "slim"
require "state_machine"

module Crowdblog
  autoload :Devise, 'crowdblog/devise/failure_app'
end
