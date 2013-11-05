source 'https://rubygems.org'
# source 'http://gems.github.com'
# Delete all gems: gem list | cut -d' ' -f1 | xargs gem uninstall -aIx
# for i in `gem list --no-versions`; do gem uninstall -aIx $i; done

gem 'rails', '~> 4.0.1'
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

gem 'select2-rails'
gem 'compass-rails', '~> 2.0.alpha.0'

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
gem 'the_sortable_tree'

gem 'the_string_to_slug',
  #, path: '../the_string_to_slug' #, '~> 0.0.6'
  github: 'the-teacher/the_string_to_slug',
  branch: 'master'

gem 'the_role',
  path: '../the_role'
  # github: 'the-teacher/the_role',
  # branch: 'master'

gem 'the_storages',
  #, path: '../the_storages'
  github: 'the-teacher/the_storages',
  branch: 'master'

gem "the_comments", "~> 2.1.0"
  # path: '../the_comments'
  # github: 'the-teacher/the_comments',
  # branch: 'master'

gem 'the_audit',
  #, path: '../the_audit'
  github: 'open-cook/the_audit',
  branch: 'master'

# Gems used only for assets and not required
# in production environments by default.
group :assets do  
  gem 'bootstrap-sass', github: 'thomas-mcdonald/bootstrap-sass'
  gem 'uglifier', '>= 1.0.3'
  gem 'sprockets-rails'
  gem 'coffee-rails'
  gem 'sass-rails'
end

group :development, :test do
  gem 'colored'
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