module UsersMacros
  class << self
    def create_admin
      role = RolesMacros.create_admin_role
      user = FactoryGirl.create(:admin_user)
      user.update( role: Role.with_name(:admin) )
    end

    def create_user
      "y"
    end
  end
end
