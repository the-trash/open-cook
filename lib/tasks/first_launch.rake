# encoding: UTF-8
require "#{Rails.root}/db/seeds/support/hubs_build"

def basic_permissions
  {
    new:     true,
    index:   true,
    show:    true,
    create:  true,
    edit:    true,
    update:  true,
    delete:  true,

    manage:  true,
    rebuild: true
  }
end

namespace :db do
  # rake db:check
  # task check: :environment do     
  # end

  namespace :create do
    # rake db:create:admin
    desc "create admin"
    task admin: :environment do
      TheRole.create_admin_role!
      User.create_admin!

      puts "First User (admin) created"
      puts "Login: [admin], Password: [qwerty]"
      puts '~'*40
    end

    # rake db:create:user_role
    desc "create user role"
    task user_role: :environment do
      Role.create!(
        name:  :user,
        title: :user,
        description: "regular user",
        the_role: {
          users: {
            cabinet: true
          },
          posts: basic_permissions,
          available_hubs: {
            posts: true,

            interviews: true,
            articles: true,
            recipes: true,
            videos: true,
            blogs: true
          }
        }
      )
    end

    # rake db:create:blogger_role
    desc "create blogger role"
    task blogger_role: :environment do
      Role.create!(
        name:  :blogger,
        title: :blogger,
        description: "blogger",
        the_role: {
          users: {
            cabinet: true
          },
          posts: basic_permissions,
          available_hubs: {
            blogs: true
          }
        }
      )
    end

    # rake db:create:first_user
    desc "create first user"
    task first_user: :environment do
      User.create!(
        login: :ilya_zykin,
        username: "Ilya N. Zykin",
        email: "zykin-ilya@ya.ru",
        password: "qwerty",
        role: Role.with_name(:user)
      )
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