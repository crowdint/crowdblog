module Crowdblog
  class User
    attr_accessor :email
    attr_accessor :name
    attr_accessor :id

    def is_publisher?
      true
    end

    def self.primary_key
      "id"
    end

    def [](value)
      []
    end

    def destroyed?
      false
    end

    def new_record?
      true
    end

    def save(*)
    end
  end
end
