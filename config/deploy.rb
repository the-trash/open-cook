load "config/capistrano/helpers"

# =========================================================
# Params
# =========================================================
set :site_name,   "zykin-ilya.ru"

# base vars
set :application, site_name
set :user,        "open_cook_web"
set :users_home,  "/var/www/open_cook_web/data"
set :deploy_to,   "#{users_home}/www/#{application}"
set :repository,  "git@github.com:open-cook/open-cook.git"
default_run_options[:shell] = "/bin/bash --login"

# helper vars
set :gemset,    'source "$HOME/.rvm/scripts/rvm" && rvm gemset use open-cook '
set :app_env,   "RAILS_ENV=production "
set :to_app,    "cd #{release_path} "

# deploy params
set :scm,         :git
set :branch,      :master
set :deploy_via,  :remote_cache
server site_name, :app, :web, :db, primary: true

# connection params
set :use_sudo, false
default_run_options[:pty] = true
set :ssh_options, { forward_agent: true }

# releases cleanup
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# =========================================================
# Tasks
# =========================================================
namespace :web_server do
  %w[start restart stop force force-stop].each do |action|
    desc "cap web_server:#{action}"
    task action do
      run _join [gemset, "#{current_path}/bin/unicorn #{action}"]
    end
  end

  desc "cap web_server:configs"
  task :configs do
    dir_conf = "#{shared_path}/config"
    dir_pids = "#{shared_path}/pids"
    dir_bin  = "#{shared_path}/bin"
    
    run "mkdir -p #{dir_conf}"
    run "mkdir -p #{dir_bin}"

    set_default(:unicorn_workers, 4)
    set_default(:unicorn_user)   { user }
    set_default(:unicorn_pid)    { "#{dir_pids}/unicorn.pid" }
    set_default(:unicorn_sock)   { "#{dir_pids}/unicorn.sock" }
    set_default(:unicorn_config) { "#{dir_conf}/unicorn_config.rb" }
    set_default(:unicorn_log)    { "#{shared_path}/log/unicorn.log" }
    set_default(:unicorn_err)    { "#{shared_path}/log/unicorn.err" }
    set_default(:gemset_use)     { _join ["cd #{current_path}", gemset] }

    template("database.production.yml", "#{dir_conf}/database.yml")

    template("nginx_conf.rb",     "#{dir_conf}/nginx.conf")
    template("unicorn_config.rb", "#{dir_conf}/unicorn_config.rb")
    template("unicorn_server.rb", "#{dir_bin}/unicorn_server")

    run "chmod 744 #{shared_path}/bin/unicorn_server"
  end
end

namespace :app do
  task :symlinks do
    run "ln -nfs #{shared_path}/system              #{release_path}/public/system"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/bin/unicorn_server  #{release_path}/bin/unicorn"
  end
end

namespace :bundle do
  desc "cap deploy bundle:install"
  task :install do
    run _join [to_app, gemset, "bundle install --without test development "]
  end
end

# cap first:launch
namespace :first do
  task :launch do
    deploy.setup
    deploy.cold
  end
end

namespace :deploy do
  task :migrate do
    web_server.configs
    bundle.install
    app.symlinks

    run _join [to_app, gemset, app_env + "rake db:migrate"]
  end

  task :restart, roles: :app, except: { no_release: true } do
    app.symlinks
    bundle.install
    run _join [to_app, gemset, app_env + "rake db:migrate"]
    run _join [to_app, gemset, app_env + "rake assets:precompile"]
    web_server.restart
  end
end

# =========================================================
# Trash
# =========================================================

# role :web, application
# role :app, application
# role :db,  application, primary: true

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# namespace :db do
#   desc "cap db:create"
#   task :create do
#     run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
#     run _join [to_app, gemset, app_env + "rake db:create"]
#   end
# end

# release_path # shared_path
# set :gem,      "#{users_home}/.rvm/rubies/ruby-2.0.0-p247/bin/gem"
# set :ruby,     "#{users_home}/.rvm/rubies/ruby-2.0.0-p247/bin/ruby"
# set :rake,     "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/rake"
# set :bundle,   "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"
# set :unicorn,  "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"