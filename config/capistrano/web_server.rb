namespace :web_server do
  %w[start restart stop force force-stop].each do |action|
    desc "cap web_server:#{action}"
    task action do
      run _join [gemset, "#{current_path}/bin/unicorn #{action}"]
    end
  end
end