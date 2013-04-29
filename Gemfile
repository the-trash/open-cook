source 'http://rubygems.org'
# source 'http://gems.github.com'
# Delete all gems: gem list | cut -d" " -f1 | xargs gem uninstall -aIx

gem 'rails', github: 'rails/rails'
gem 'arel',  github: 'rails/arel'

gem 'mysql2'
gem 'sqlite3'

# gem 'rails-i18n'
# Tags need refactor for Rails MassAttrProtect

gem 'sorcery', git: "git@github.com:NoamB/sorcery.git"

gem 'jquery-rails'
gem 'jbuilder', '~> 1.0.1'

gem 'compass'
gem 'kaminari'

gem 'russian'
gem 'sanitize'
gem "state_machine", "~> 1.2.0"
gem 'haml'              , git:  'git@github.com:haml/haml.git', tag: "4.0.1"
gem 'awesome_nested_set', git: "git@github.com:collectiveidea/awesome_nested_set.git", branch: "rails4"

# gem 'acts-as-taggable-on'
# gem 'ruby-graphviz' # state machine visualization

gem 'the_role'     , path: '../the_role'
gem 'the_audit'    , path: '../the_audit'
gem 'the_comments' , path: '../the_comments'

# gem 'rmagick'
# gem 'paperclip', '2.3.6'
# gem 'the_storages'  , path: '/home/the_teacher/rails/rails4/the_storages'

group :development do; end

# Gems used only for assets and not required
# in production environments by default.
group :assets do  
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'coffee-rails',    github: 'rails/coffee-rails'
  gem 'sass-rails',      github: 'rails/sass-rails'
  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', '~> 2.2.2.0'
end

group :development, :test do
  gem 'faker'

  gem 'thin'
  # gem 'unicorn'

  # gem 'rspec'
  # gem 'rspec-rails'
  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"

  gem 'capybara' # Browser testing
end

group :test do
  gem 'database_cleaner'
  
  gem 'factory_girl'
  # gem 'factory_girl_rails'

  # test helpers
  gem 'cucumber-rails', :require => false # elegant BDD

  # autotest
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'

  # gem 'email_spec'  # emails specs
  # gem 'timecop'     # Time delays test
  # gem 'launchy'     # show broken cucumber tests

  # Pretty printed test output
  # gem 'turn' , '~> 0.8.3', :require => false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'