module RolesMacros
  class << self
    def create_admin_role
      role = FactoryGirl.create(:admin_role)
      role.create_rule(:system, :administrator)
      role.rule_on(:system, :administrator)
      role
    end

    def create_blogger_role
      role = FactoryGirl.create(:blogger_role)
      blogger_role_hash = {
        users:  {
          cabinet: true
        },
        posts: {
          new:     true,
          create:  true,
          edit:    true,
          update:  true,
          destroy: true
        },
        available_hubs: {
          videos: true,
          articles: true
        }
      }
      role.update_role(blogger_role_hash)
      role
    end
  end
end