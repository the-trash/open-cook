def basic_permissions
  {
    new:     true,
    index:   true,
    show:    true,
    create:  true,
    edit:    true,
    update:  true,
    delete:  true,
    rebuild: true
  }
end

namespace :db do
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
  end

  namespace :first do
    # rake db:first:top_sections
    desc "create top sections"
    task top_sections: :environment do
      admin = User.root

      hub = Hub.create!(
        user:  admin,
        title: :TopSections,
        slug:  :top_sections,
        state: :published
      )

      %w[Recipes Posts Interviews Videos Blogs].each do |name|
        section = Hub.create!(
          user:  admin,
          title: name,
          slug:  name.downcase,
          state: :published
        )
        section.move_to_child_of hub
        print '.'
      end

      puts
      puts "Top sections created"
    end

    # rake db:first:pages
    desc "create static pages"
    task pages: :environment do
      admin = User.root

      hub = Hub.create!(
        user:  admin,
        title: :StaticPages,
        slug:  :static_pages,
        pubs_type: :pages,
        state: :published
      )

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
      Rake::Task["db:create:first_user"].invoke

      Rake::Task["db:first:pages"].invoke
      Rake::Task["db:first:top_sections"].invoke
    end
  end
end