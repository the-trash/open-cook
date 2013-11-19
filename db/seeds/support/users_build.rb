module UsersBuild
  class << self
    def create_admin!
      TheRole.create_admin_role!
      User.create_admin!

      puts "First User (admin) created"
      puts "Login: [admin], Password: [qwerty]"
      puts '~'*40
    end

    def ilya_zykin!
      User.create!(
        login: :ilya_zykin,
        username: "Ilya N. Zykin",
        email: "zykin-ilya@ya.ru",
        password: "qwerty",
        role: Role.with_name(:user)
      )
    end
  end
end