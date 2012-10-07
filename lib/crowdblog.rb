require "crowdblog/engine"

require "carrierwave"
require "devise"
require "gravtastic"
require "jbuilder"
require "redcarpet"
require "slim"
require "state_machine"
require "strong_parameters"

module Crowdblog
  autoload :Devise, 'crowdblog/devise/failure_app'
end
