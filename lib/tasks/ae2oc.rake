require "#{Rails.root}/lib/tasks/includes/connect_ae_db"
require "#{Rails.root}/lib/tasks/includes/ae2oc_db"

# rake ae:user_start
namespace :ae do
  desc "Перетягиваем пользователей"
  task user_start: :environment do
    puts "User start =>"
    ae_users = AE_User.all
    user_count = ae_users.count

    # open_password - ?
    ae_users.each_with_index do |aeuser, index|
      user = User.new(
        login: aeuser.email,
        username: aeuser.nick,
        email: aeuser.email,
        role_id: aeuser.roles,
        created_at: aeuser.created_at,
        updated_at: aeuser.updated_at,
        password: aeuser.crypted_password,
        crypted_password: aeuser.crypted_password,
        salt: aeuser.password_salt
      )

      if user.save
        puts "#{index} #{aeuser.nick} => #{index}/#{user_count}"
      else
        puts "#{aeuser.nick} - #{user.errors.to_a.to_s.red}"
      end
    end
  end

  desc "Перетягиваем теги из AE в Open-cook"
  task tags_start: :environment do
    
  end
end
