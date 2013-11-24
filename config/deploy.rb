load "config/capistrano/helpers"

# =========================================================
# Params
# =========================================================
set :site_name,   "zykin-ilya.ru"
set :server_addr, "zykin-ilya.ru"
set :application, site_name

# base vars
set :gemset_name, :zykin_ilya
set :user,        :open_cook_web
set :socket_name, :zykin_ilya_server
set :users_home,  "/var/www/open_cook_web/data"
set :deploy_to,   "#{users_home}/www/#{application}"
default_run_options[:shell] = "/bin/bash --login"

# helper vars
set :rvm_src, 'source "$HOME/.rvm/scripts/rvm"'
set :gemset,  _join([rvm_src, "rvm gemset use #{gemset_name} "])
set :app_env, "RAILS_ENV=production "
set :to_app,  "cd #{release_path} "

# deploy params
set :scm,         :git
set :deploy_via,  :remote_cache
server server_addr, :app, :web, :db, primary: true

# main repo params
set :repository,  "git@github.com:open-cook/open-cook.git"
set :branch,      "master"

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
load "config/capistrano/web_server"
load "config/capistrano/app"

# precompile assets before App reboot
before "deploy:create_symlink", "app:assets_build"

namespace :deploy do
  task :migrate do
    app.db_create
    app.db_migrate
  end

  task :restart, roles: :app, except: { no_release: true } do
    app.symlinks
    web_server.restart
  end

  task :db_update do
    deploy.update_code
    deploy.finalize_update
    app.symlinks
    app.bundle
    app.db_migrate
  end
end