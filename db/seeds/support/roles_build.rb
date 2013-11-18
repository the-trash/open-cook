module RolesBuild
  class << self
    def basic_permissions
      {
        new:     true,
        index:   true,
        show:    true,
        create:  true,
        edit:    true,
        update:  true,
        delete:  true,

        manage:  true,
        rebuild: true
      }
    end

    def regular_user!
      Role.create!(
        name:  :user,
        title: :user,
        description: "regular user",
        the_role: {
          users: {
            cabinet: true
          },
          posts: basic_permissions,
          available_hubs: {
            posts: true,

            interviews: true,
            articles: true,
            recipes: true,
            videos: true,
            blogs: true
          }
        }
      )
    end

    def blogger!
      Role.create!(
        name:  :blogger,
        title: :blogger,
        description: "blogger",
        the_role: {
          users: {
            cabinet: true
          },
          posts: basic_permissions,
          available_hubs: {
            blogs: true
          }
        }
      )
    end
  end
end