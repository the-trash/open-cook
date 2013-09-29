source 'https://rubygems.org'
# source 'http://gems.github.com'
# Delete all gems: gem list | cut -d' ' -f1 | xargs gem uninstall -aIx
# for i in `gem list --no-versions`; do gem uninstall -aIx $i; done

gem 'rails', '~> 4.0.0'
gem 'unicorn'

gem 'mysql2'
gem 'sqlite3'
gem 'capistrano'

# App level
gem 'sorcery'
gem 'RedCloth', require: 'redcloth'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 1.0.1'

gem 'compass'
gem 'kaminari'

gem 'haml'
gem 'sanitize'
gem 'state_machine', '~> 1.2.0'

gem 'acts-as-taggable-on', github: "mbleigh/acts-as-taggable-on",       branch: "master"
gem 'awesome_nested_set',  github: "collectiveidea/awesome_nested_set", branch: "master"

# gem 'rmagick'
gem 'mini_magick'
gem 'paperclip'

# DJ
gem 'daemons'

gem 'delayed_job',
  git: 'https://github.com/collectiveidea/delayed_job.git',
  tag: 'v4.0.0.beta2'

gem 'delayed_job_active_record',
  git: 'https://github.com/collectiveidea/delayed_job_active_record.git',
  tag: 'v4.0.0.beta3'

# Open Cook components
gem 'the_string_to_slug', path: '../the_string_to_slug' #, '~> 0.0.6'
gem 'the_role'     , path: '../the_role'
gem 'the_audit'    #, path: '../the_audit'
gem 'the_storages' #, path: '../the_storages'
gem 'the_comments' , path: '../the_comments'
gem 'the_sortable_tree'

# Gems used only for assets and not required
# in production environments by default.
group :assets do  
  gem 'sprockets-rails'
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', '~> 2.3'
end

group :development, :test do
  gem 'thin'
  gem 'faker'
  gem 'seedbank', github: 'james2m/seedbank'

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

  # Pretty printed test output
  # gem 'turn' , '~> 0.8.3', :require => false
end