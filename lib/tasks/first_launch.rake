namespace :db do
  namespace :first do
    # rake db:first:user
    desc "create first user"
    task user: :environment do
      User.create!(
        login: :admin,
        email: "admin@site.com",
        password: "qwerty"
      )
    end

    # rake db:first:launch
    desc "create example hubs"
    task hubs: :environment do
      def create_system_hub slug, title
        User.root.hubs.create!(
          slug:  slug,
          title: title,
          state: :published
        )
      end

      create_system_hub(:articles, 'Articles')
      create_system_hub(:videos,   'Videos')
      create_system_hub(:blogs,    'Blogs')

      puts "Basic Hubs created"
    end

    # rake db:first:launch
    desc "before first CMS start"
    task launch: :environment do
      Rake::Task["db:bootstrap"].invoke
      Rake::Task["db:roles:admin"].invoke
      Rake::Task["db:first:user"].invoke
      Rake::Task["db:first:hubs"].invoke
    end
  end
end