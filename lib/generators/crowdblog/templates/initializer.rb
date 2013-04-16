Crowdblog.user_class = '<%= user_class %>'

Crowdblog.user_class.class_eval do
  define_method :is_publisher?, -> { true }
end