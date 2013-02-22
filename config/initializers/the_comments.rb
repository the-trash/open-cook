TheComments.configure do |config|
  config.tolerance_time = 100
  config.empty_inputs   = [:email, :message]
end