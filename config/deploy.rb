def _join *params
  params.join ' && '
end

def template(from, to)
  script_root = File.dirname File.absolute_path __FILE__
  erb         = File.read script_root + "/capistrano/templates/#{from}"
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

# cap deploy:setup
# cap deploy:cold

# =========================================================
# Params
# =========================================================
set :application, "open-cook.ru"

set    :site_name, "zykin-ilya.ru"
server site_name,  :app, :web, :db, :primary => true

set :scm,        :git
set :branch,     :master
set :deploy_via, :remote_cache
set :repository, "git@github.com:open-cook/open-cook.git"

set :user,       :open_cook_web
set :users_home, "/var/www/open_cook_web/data"

set :use_sudo, false
set :keep_releases, 10

default_run_options[:pty]   = true
default_run_options[:shell] = "/bin/bash --login"

set :ssh_options, { forward_agent: true }
set :deploy_to,   "#{users_home}/www/#{application}"

set :gemset,    'source "$HOME/.rvm/scripts/rvm" && rvm gemset use open-cook'
set :app_env,   'RAILS_ENV=production '
set :to_app,    "cd " + release_path


# =========================================================
# Tasks
# =========================================================
after "deploy:cold", "web_server:configs"

namespace :web_server do
  desc "cap web_server:configs"
  task :configs do
    puts "*!"*40

    set_default(:unicorn_workers, 4)
    set_default(:unicorn_user)   { user }
    set_default(:unicorn_pid)    { "#{current_path}/tmp/pids/unicorn.pid" }
    set_default(:gemset_use)     { _join ["cd #{current_path}", gemset] }
    set_default(:unicorn_config) { "#{shared_path}/config/unicorn_config.rb" }
    set_default(:unicorn_log)    { "#{shared_path}/log/unicorn.log" }

    template("nginx_conf.rb",     "#{shared_path}/config/nginx.conf")
    template("unicorn_config.rb", "#{shared_path}/config/unicorn_config.rb")
    template("unicorn_server.rb", "#{shared_path}/bin/unicorn_server")

    run "chmod 744 #{shared_path}/bin/unicorn_server"
  end
end

namespace :deploy do
  task :app_symlinks do
    run "ln -nfs #{shared_path}/system              #{release_path}/public/system"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"  
  end
end

namespace :bundle do
  desc "cap deploy bundle:install"
  task :install do
    run _join [to_app, gemset, "bundle install --without test development "]
  end
end

# CODE UPDATE
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :migrate do
    bundle.install
    deploy.app_symlinks
    run _join [to_app, gemset, app_env + "rake db:migrate"]
  end

  task :start do ; end
  task :stop  do ; end
  task :restart, roles: :app, except: { no_release: true } do
    bundle.install
    run _join [to_app, gemset, app_env + "rake db:migrate"]
    run _join [to_app, gemset, app_env + "rake assets:precompile"]
    # p "RESTART SERVER"
    # run gemset_init + "rvm gemset name"
    # run gemset_init + "rvm gemset use open-cook"
    # run gemset_init + "rvm gemset name"
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