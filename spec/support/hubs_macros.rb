module HubsMacros
  def self.create_basic_hubs
    create_system_hub(:articles, :articles)
    create_system_hub(:videos,   :videos)
    create_system_hub(:blogs,    :blogs)
  end

  def self.create_system_hub title, slug = nil
    User.root.hubs.create!(
      title: title,
      slug:  slug,
      state: :published
    )
  end
end