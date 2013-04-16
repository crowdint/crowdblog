Crowdblog.user_class = 'User'

Crowdblog.user_class.class_eval do
  define_method :is_publisher?, -> { true }
end