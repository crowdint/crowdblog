require "crowdblog/engine"

require "carrierwave"
require "gravtastic"
require "jbuilder"
require "redcarpet"
require "slim"
require "state_machine"

require "generators/crowdblog/views_generator"

module Crowdblog
  @@author_user_class_name    = 'User'
  @@publisher_user_class_name = 'User'

  mattr_accessor :author_user_class_name
  mattr_accessor :publisher_user_class_name
end
