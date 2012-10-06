user = Crowdblog::User.new
user.email                 = "test@example.com"
user.password              = "123456"
user.password_confirmation = "123456"

user.save!
