set :application, "open-cook.ru"

role :web, application
role :app, application
role :db,  application, primary: true

set :scm,        :git
set :branch,     :master
set :deploy_via, :remote_cache
set :repository, "git@github.com:open-cook/open-cook.git"

set :keep_releases, 10

set :user, "open_cook_web"
default_run_options[:pty] = true
set :ssh_options, { forward_agent: true }

set :deploy_to,   "~/www/#{application}"
set :current_dir, "#{deploy_to}/current/"

set :ruby,   "~/.rvm/rubies/ruby-2.0.0-p247/bin/ruby"
set :rake,   "~/.rvm/gems/ruby-2.0.0-p247@global/bin/rake"
set :bundle, "~/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"

# clean up old releases on each deploy
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end