set_default(:dir_conf, "#{shared_path}/config")
set_default(:dir_pids, "#{shared_path}/pids")
set_default(:dir_bin,  "#{shared_path}/bin")

set_default(:unicorn_workers, 4)

set_default(:unicorn_user)   { user }
set_default(:unicorn_pid)    { "#{dir_pids}/unicorn.pid" }
set_default(:unicorn_sock)   { "#{dir_pids}/unicorn.sock" }
set_default(:unicorn_config) { "#{dir_conf}/unicorn_config.rb" }
set_default(:unicorn_log)    { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_err)    { "#{shared_path}/log/unicorn.err" }
set_default(:gemset_use)     { _join ["cd #{current_path}", gemset] }

namespace :app do
  # cap app:first_launch
  desc "cap app:first_launch"
  task :first_launch do
    app.gemset_create
    deploy.setup
    deploy.cold
    app.assets_build
    web_server.start
  end
  
  # cap app:db_create
  desc "cap app:gemset_create"
  task :gemset_create do
    run _join [rvm_src, "rvm gemset create #{gemset_name}"]
  end

  # cap app:db_create
  desc "cap app:db_create"
  task :db_create do
    run _join [to_app, gemset, app_env + "rake db:create"]
  end

  # cap app:db_migrate
  desc "cap app:db_migrate"
  task :db_migrate do
    run _join [to_app, gemset, app_env + "rake db:migrate"]
  end

  # cap app:assets_build
  desc "cap app:assets_build"
  task :assets_build do
    run _join [to_app, gemset, app_env + "rake assets:precompile"]
  end

  # cap app:hard_destroy
  desc "cap app:hard_destroy"
  task :hard_destroy do
    run "rm -rf #{deploy_to}"
  end

  # cap app:soft_destroy
  desc "cap app:soft_destroy"
  task :soft_destroy do
    web_server.stop
    run "rm -rf #{deploy_to}"
  end  

  # cap app:symlinks
  desc "cap app:symlinks"
  task :symlinks do
    run "mkdir -p #{release_path}/bin"
    run "rm -f #{release_path}/Gemfile.lock"
    # files
    run "ln -nfs #{shared_path}/bin/unicorn_server  #{release_path}/bin/unicorn"
    run "ln -nfs #{shared_path}/config/Gemfile.lock #{release_path}/Gemfile.lock"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # folders
    run "ln -nfs #{shared_path}/system              #{release_path}/public/system"
    run "ln -nfs #{shared_path}/upload              #{release_path}/public/upload"
  end

  # cap app:configs
  desc "cap app:configs"
  task :configs do
    run "mkdir -p #{release_path}/bin"
    run "mkdir -p #{dir_conf}"
    run "mkdir -p #{dir_bin}"

    template("nginx_conf.rb",     "#{dir_conf}/nginx.conf")
    template("unicorn_config.rb", "#{dir_conf}/unicorn_config.rb")
    template("unicorn_server.rb", "#{dir_bin}/unicorn_server")

    template("database.production.yml", "#{dir_conf}/database.yml")

    run "chmod 744 #{shared_path}/bin/unicorn_server"
  end

  # cap app:bundle
  desc "cap app:bundle"
  task :bundle do
    run "rm -f #{release_path}/Gemfile.lock"
    run _join [to_app, gemset, "bundle install --without test development"]
    run "cp #{release_path}/Gemfile.lock #{shared_path}/config/Gemfile.lock"
    run "rm -f #{release_path}/Gemfile.lock"
    run "ln -nfs #{shared_path}/config/Gemfile.lock  #{release_path}/Gemfile.lock"
  end
end