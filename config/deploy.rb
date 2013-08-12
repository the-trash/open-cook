set :application, "open-cook.ru"

server "zykin-ilya.ru", :app, :web, :db, :primary => true

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

set :rvm_init, 'source "$HOME/.rvm/scripts/rvm"'
default_run_options[:data]  = "#{rvm_init} && rvm gemset use open-cook"

set :ssh_options, { forward_agent: true }
set :deploy_to,   "#{users_home}/www/#{application}"

# set :gem,      "#{users_home}/.rvm/rubies/ruby-2.0.0-p247/bin/gem"
# set :ruby,     "#{users_home}/.rvm/rubies/ruby-2.0.0-p247/bin/ruby"
# set :rake,     "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/rake"
# set :bundle,   "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"
# set :unicorn, "#{users_home}/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"

# clean up old releases on each deploy
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  task :restart, roles: :app, except: { no_release: true } do
    p "RESTART SERVER"
    run "rvm gemset name"
    run "rvm gemset use open-cook"
    run "rvm gemset name"
  end
end

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