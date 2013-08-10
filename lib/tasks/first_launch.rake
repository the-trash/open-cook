namespace :db do
  namespace :first do
    # rake db:first:user
    desc "create first user"
    task user: :environment do
      user = User.create!(
        login: :admin,
        email: "admin@site.com",
        password: "qwerty"
      )

      user.update( role: Role.with_name(:admin) )

      puts "First User (admin) created"
      puts "Login: [admin], Password: [qwerty]"
      puts '~'*40
    end

    # rake db:first:launch
    desc "before first CMS start"
    task launch: :environment do
      Rake::Task["db:bootstrap"].invoke
      Rake::Task["db:seed:development"].invoke
    end
  end
end