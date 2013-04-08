source 'http://rubygems.org'
# source 'http://gems.github.com'
# Delete all gems: gem list | cut -d" " -f1 | xargs gem uninstall -aIx

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'

# gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

# gem 'mysql2'
gem 'sqlite3'

# gem 'rails-i18n'
# Tags need refactor for Rails MassAttrProtect

# gem 'strong_parameters',    git: 'https://github.com/rails/strong_parameters.git', :tag => "v0.1.6"
gem 'protected_attributes', git: 'https://github.com/rails/protected_attributes.git'

gem 'sorcery'

gem 'jbuilder', '~> 1.0.1'
gem 'jquery-rails'

gem 'compass'
gem 'kaminari'

gem 'russian'
gem 'sanitize'
gem 'nested_set'

gem 'haml'              , git:  'git@github.com:haml/haml.git', tag: "4.0.1" #, branch: 'stable'

gem "state_machine", "~> 1.2.0"

# gem 'acts-as-taggable-on'
# gem 'state_machine' , git:  'git@github.com:pluginaweek/state_machine.git'

# gem "the_sortable_tree", "~> 2.3.0"
# gem 'the_sortable_tree' #, path: '/home/the_teacher/rails/rails4/the_sortable_tree'

# w
gem 'the_role'     , path: '/home/zykin/work/projects/old_code/myg/the_role'
gem 'the_audit'    , path: '/home/zykin/work/projects/old_code/myg/the_audit'
gem 'the_comments' , path: '/home/zykin/work/projects/old_code/myg/the_comments'

# h
# gem 'the_role'            , path: '/home/the_teacher/rails/rails4/the_role'
# gem 'the_audit'           , path: '/home/the_teacher/rails/rails4/the_audit'
# gem 'the_comments'        , path: '/home/the_teacher/rails/rails4/the_comments'

# gem 'the_uploaded_files'  , path: '/home/the_teacher/rails/rails4/the_uploaded_files'

# gem 'paperclip', '2.3.6'
# gem 'rmagick'

group :development do
  # Use unicorn as the app server
  gem 'unicorn'
  # gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do  
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'coffee-rails',    github: 'rails/coffee-rails'
  gem 'sass-rails',      github: 'rails/sass-rails'
  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', '~> 2.2.2.0'
end

group :test, :development do
  gem 'faker'
  gem 'factory_girl'

  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'