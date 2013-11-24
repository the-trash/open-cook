TheRole.configure do |config|
  config.default_user_role = :user
  config.layout            = :application
  config.first_user_should_be_admin = true
end