TheComments.configure do |config|
  # TheComments.config.param_name = value
  config.max_reply_depth = 3
  config.tolerance_time  = 15
  config.empty_inputs    = [:email, :message]
end