require "crowdblog/engine"

require "carrierwave"
require "gravtastic"
require "jbuilder"
require "redcarpet"
require "slim"
require "state_machine"
require "strong_parameters"

require "generators/crowdblog/views_generator"

module Crowdblog
  mattr_accessor :user_class

  class << self
    def user_class
      if @@user_class.is_a?(Class)
        raise StandardError.new 'Karma user_class must be defined as string'

      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end
  end
end
