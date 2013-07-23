source 'http://rubygems.org'
# source 'http://gems.github.com'
# Delete all gems: gem list | cut -d' ' -f1 | xargs gem uninstall -aIx

gem 'rails', '~> 4.0.0'

gem 'mysql2'
gem 'sqlite3'

gem 'sorcery'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 1.0.1'

gem 'compass'
gem 'kaminari'

gem 'sanitize'
gem 'state_machine', '~> 1.2.0'
gem 'haml' 
gem 'acts-as-taggable-on'
gem 'awesome_nested_set'

# gem 'rmagick'
gem 'mini_magick'
gem 'paperclip'

gem 'daemons'

gem 'delayed_job',
  git: 'https://github.com/collectiveidea/delayed_job.git',
  tag: 'v4.0.0.beta2'

gem 'delayed_job_active_record',
  git: 'https://github.com/collectiveidea/delayed_job_active_record.git',
  tag: 'v4.0.0.beta3'

# Open Cook components
gem 'the_string_to_slug', '~> 0.0.5'
gem 'the_role'    , path: '../the_role'
gem 'the_audit'   , path: '../the_audit'
gem 'the_storages', path: '../the_storages'
gem 'the_comments', path: '../the_comments'

gem 'the_sortable_tree'

group :development do
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do  
  gem 'sprockets-rails'
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', '~> 2.2.2.0'
end

group :development, :test do
  gem 'faker'

  gem 'rspec'
  gem 'rspec-core'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'rspec-expectations'
end

group :test do
  gem 'capybara'
  gem 'factory_girl'
  gem 'database_cleaner'

  # autotest
  # gem 'guard'
  # gem 'guard-rspec'
  # gem 'guard-spork'

  # elegant BDD
  # gem 'cucumber-rails', :require => false

  # Test helpers
  # gem 'email_spec'  # emails specs
  # gem 'timecop'     # Time delays test
  # gem 'launchy'     # show broken cucumber tests

  # Pretty printed test output
  # gem 'turn' , '~> 0.8.3', :require => false
end