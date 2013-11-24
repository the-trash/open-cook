# encoding: UTF-8
require "#{Rails.root}/db/seeds/support/hubs_build"
require "#{Rails.root}/db/seeds/support/users_build"
require "#{Rails.root}/db/seeds/support/roles_build"

namespace :db do
  namespace :create do
    # rake db:create:admin
    desc "create admin"
    task admin: :environment do
      UsersBuild.create_admin!
    end

    # rake db:create:user_role
    desc "create user role"
    task user_role: :environment do
      RolesBuild.regular_user!
      puts "Regular user role created"
    end

    # rake db:create:blogger_role
    desc "create blogger role"
    task blogger_role: :environment do
      RolesBuild.blogger!
      puts "Blogger role created"
    end

    # rake db:create:first_user
    desc "create first user"
    task first_user: :environment do
      UsersBuild.ilya_zykin!
      puts "First user created"
    end

    # rake db:create:system_hubs
    desc "create system_hubs"
    task system_hubs: :environment do
      HubsBuild.create_system_hub(:system_pages, 'System pages', :pages)

      system_hub = HubsBuild.create_system_hub(:system_hubs, 'System hubs', :pages)

      HubsBuild.create_system_hub(:interviews, 'Interviews',   :posts, system_hub)
      HubsBuild.create_system_hub(:articles,   'Articles',     :posts, system_hub)
      HubsBuild.create_system_hub(:recipes,    'Recipes',      :posts, system_hub)
      HubsBuild.create_system_hub(:videos,     'Videos',       :posts, system_hub)
      HubsBuild.create_system_hub(:blogs,      'Blogs',        :posts, system_hub)

      puts "Basic Hubs created"
    end
  end

  namespace :first do
    # rake db:first:pages
    desc "create static pages"
    task pages: :environment do
      admin = User.root
      hub   = Hub.with_slug(:system_pages)

      %w[About Help Policy].each do |name|
        section = Page.create!(
          user:  admin,
          hub:   hub,
          title: name,
          state: :published
        )
        print '.'
      end

      puts
      puts "Bottom section and pages created"
    end

    # rake db:first:launch
    desc "before first CMS start"
    task launch: :environment do
      Rake::Task["db:bootstrap"].invoke
      Rake::Task["db:create:admin"].invoke
      Rake::Task["db:create:user_role"].invoke
      Rake::Task["db:create:blogger_role"].invoke

      Rake::Task["db:create:first_user"].invoke
      Rake::Task["db:create:system_hubs"].invoke

      Rake::Task["db:first:pages"].invoke
    end
  end
end