## Deploy

### SSH without password

Local machine:

```
ssh-keygen -t rsa -C "zykin-ilya@ya.ru"
```

```
Enter file in which to save the key (/home/USER/.ssh/id_rsa): zykin_ilya

Enter passphrase (empty for no passphrase): ENTER
```

```
scp ~/.ssh/zykin_ilya.pub open_cook_web@185.4.85.70:~/zykin_ilya.pub
```

```ruby
ssh open_cook_web@185.4.85.70
mkdir -p ~/.ssh && cat ~/zykin_ilya.pub >> ~/.ssh/authorized_keys && rm ~/zykin_ilya.pub
chmod 711 ~/.ssh && chmod 600 ~/.ssh/authorized_keys
```

### Capistrano

```
server$ which ruby
server$ which rake
server$ which bundle
```

**config/deploy.rb** example

```
set :application, "open-cook.ru"

role :web, application
role :app, application
role :db,  application, primary: true

set :scm,        :git
set :branch,     :master
set :deploy_via, :remote_cache
set :repository, "git@github.com:open-cook/open-cook.git"

set :keep_releases, 10

default_run_options[:pty] = true
set :ssh_options, { forward_agent: true }

set :deploy_to,   "~/www/#{application}"
set :current_dir, "#{deploy_to}/current/"

set :ruby,   "~/.rvm/rubies/ruby-2.0.0-p247/bin/ruby"
set :rake,   "~/.rvm/gems/ruby-2.0.0-p247@global/bin/rake"
set :bundle, "~/.rvm/gems/ruby-2.0.0-p247@global/bin/bundle"

# clean up old releases on each deploy
after "deploy:restart", "deploy:cleanup"
```

List of capistrano tasks

```
cap -T

cap deploy:setup
cap deploy
```

