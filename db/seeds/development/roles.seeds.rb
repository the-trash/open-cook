after 'development:clean' do
  admin_role = Role.create!(
    name: :admin,
    title: "Admin Role",
    description: "Admin can do anything"
  )

  blogger = Role.create!(
    name: :blogger,
    title: "Blogger role",
    description: "Blogger can manage his Comments and post in Blog hub"
  )

  author = Role.create!(
    name: :author,
    title: "Author role",
    description: "Blogger can manage his Comments and Post in Few Hubs (Articles, Blogs, Recipes, Videos)"
  )

  #######################################################
  # Update Role's Abilities
  #######################################################

  admin_role.create_rule(:system, :administrator)
  admin_role.rule_on(:system, :administrator)

  blogger.update_role(
    users: {
      cabinet: true
    },
    posts: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    },
    available_hubs: {
      blogs: true
    }
  )

  author.update_role(
    users: {
      cabinet: true
    },
    posts: {
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      rebuild: true,
      destroy: true
    },
    available_hubs: {
      blogs:    true,
      videos:   true,
      recipes:  true,
      articles: true,
      interviews: true
    }
  )

  puts "Roles created"
end