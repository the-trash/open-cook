namespace :db do
  namespace :first do
    # rake db:first:user
    desc "create first user"
    task user: :environment do
      TheRole.create_admin_role!
      User.create_admin!

      puts "First User (admin) created"
      puts "Login: [admin], Password: [qwerty]"
      puts '~'*40
    end

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

      %w[Recipes Posts Interviews Videos Blog].each do |name|
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
      Rake::Task["db:first:user"].invoke
      Rake::Task["db:first:pages"].invoke
      Rake::Task["db:first:top_sections"].invoke
    end
  end
end