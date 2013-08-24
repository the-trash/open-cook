rails_root = "<%= current_path %>"
pid_file   = "<%= unicorn_pid  %>"
socket_file= "<%= unicorn_sock %>"
log_file   = "<%= unicorn_log  %>"
err_log    = "<%= unicorn_err  %>"
old_pid    = pid_file + '.oldbin'

pid pid_file
preload_app true
stderr_path err_log
stdout_path log_file

timeout 30
listen socket_file, backlog: 1024

working_directory rails_root
worker_processes <%= unicorn_workers %>

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!

  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end