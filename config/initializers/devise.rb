Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender               = "please-change-me-at-config-initializers-devise@example.com"
  config.apply_schema                = false
  config.case_insensitive_keys       = [ :email ]
  config.strip_whitespace_keys       = [ :email ]
  config.skip_session_storage        = [:http_auth]
  config.stretches                   = Rails.env.test? ? 1 : 10
  config.reconfirmable               = true
  config.use_salt_as_remember_token  = true
  config.reset_password_within       = 6.hours
  config.sign_out_via                = :get

  config.warden { |manager| manager.failure_app = Crowdblog::Devise::FailureApp }
end
