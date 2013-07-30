module UsersMacros
  class << self
    def create_admin
      role = RolesMacros.create_admin_role
      user = FactoryGirl.create(:admin_user)
      user.update( role: role )
    end

    def create_blogger
      role = RolesMacros.create_blogger_role
      user = FactoryGirl.create(:user)
      user.update( role: role )
    end
  end
end
