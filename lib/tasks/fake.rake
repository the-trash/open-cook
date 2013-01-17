# bundle exec rake db:fake
namespace :db do
  task :fake => [:environment, :drop, :create, :migrate, 'roles:test', :seed] do
    desc "Recreate everything from scratch including pre-populated data"
  end
end