module RolesMacros
  def self.create_admin_role
    role = FactoryGirl.create(:admin_role)
    role.create_rule(:system, :administrator)
    role.rule_on(:system, :administrator)
    role
  end

  def self.create_user_role
    #
  end
end