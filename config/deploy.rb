load "config/capistrano/helpers"
load "config/capistrano/web_server"
load "config/capistrano/app"

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
set :gemset_name,   :zykin_ilya
set :rvm_src,       'source "$HOME/.rvm/scripts/rvm"'
set :gemset,        _join([rvm_src, "rvm gemset use #{gemset_name} "])
set :app_env,       "RAILS_ENV=production "
set :to_app,        "cd #{release_path} "

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
namespace :deploy do
  task :migrate do
    app.configs
    app.bundle
    app.symlinks
    app.db_create
    app.db_migrate
  end

  task :restart, roles: :app, except: { no_release: true } do
    app.symlinks
    app.bundle
    app.migrate
    app.assets_build
    web_server.restart
  end
end