module HubsMacros
  class << self
    def create_basic_hubs
      create_system_hub(:articles, :articles)
      create_system_hub(:videos,   :videos)
      create_system_hub(:blogs,    :blogs)
    end

    def create_system_hub title, slug = nil
      User.root.hubs.create!(
        title: title,
        slug:  slug,
        state: :published
      )
    end
  end
end