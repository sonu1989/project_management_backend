# frozen_string_literal: true

Devise.setup do |config|
  # Configure the e-mail address shown in Devise::Mailer.
  # Update with the sender email address for your application.
  config.mailer_sender = 'no-reply@yourdomain.com'

  # Load and configure the ORM. Supports :active_record (default) and :mongoid.
  require 'devise/orm/active_record'

  # Authentication keys configuration
  # Set to :email for email authentication or customize for other keys.
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Skip storing the session for :http_auth by default.
  config.skip_session_storage = [:http_auth]

  # Configure password encryption and stretching.
  # Adjust `stretches` for production and testing environments.
  config.stretches = Rails.env.test? ? 1 : 12

  # Require confirmation for changes to sensitive fields like email.
  config.reconfirmable = true

  # Set password length and email format validation.
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Set session timeout for inactive users if using :timeoutable.
  # Uncomment and adjust if needed.
  # config.timeout_in = 30.minutes

  # Configure rememberable token expiration.
  # Uncomment and adjust if using :rememberable.
  # config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true

  # Configure the reset password timeout period.
  config.reset_password_within = 6.hours

  # Set the HTTP method used to sign out. Default is :delete.
  config.sign_out_via = :delete

  # OmniAuth configuration example
  # Uncomment and configure if using OmniAuth providers.
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'

  # Configure Warden strategies.
  config.http_authenticatable = true
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end

  config.warden do |manager|
    manager.scope_defaults :user, store: false
  end

  # Hotwire/Turbo configuration for error responses and redirects.
  # Uncomment and configure if using Hotwire or Turbo.
  # config.responder.error_status = :unprocessable_entity
  # config.responder.redirect_status = :see_other
end
