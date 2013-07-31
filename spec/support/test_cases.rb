module TestCases
  class << self
    def admin_blogger_hubs
      UsersMacros.create_admin
      UsersMacros.create_blogger
      HubsMacros.create_basic_hubs
    end
  end
end