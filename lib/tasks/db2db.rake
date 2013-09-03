class OldSiteConnect < ActiveRecord::Base
  establish_connection(
    :adapter  => "mysql2",
    :host     => "localhost",
    :username => "root",
    :password => "qwerty",
    :database => "open_cook_dev",
    :encoding => "utf8"
  )
end

class OldRecipe < OldSiteConnect
  self.table_name = "recipes"
end

namespace :db do
  namespace :to do

    # rake db:to:db
    task db: :environment do
      # Rake::Task["rake db:bootstrap"].invoke
      # Rake::Task["db:first:user"].invoke
      
      root = User.root
      OldRecipe.all.each do |recipe|
      end
    end

  end
end