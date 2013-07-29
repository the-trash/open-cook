module UsersMacros
  def self.create_admin
    role = RolesMacros.create_admin_role
    user = FactoryGirl.create(:admin_user)
    user.update( role: Role.with_name(:admin) )
  end

  def self.create_user
    
  end
end
