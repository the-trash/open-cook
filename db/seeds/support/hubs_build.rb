module HubsBuild
  def self.create_system_hub slug, title, type, parent = nil
    hub = User.root.hubs.create!(
      slug:  slug,
      title: title,
      pubs_type: type,
      state: :published
    )

    hub.move_to_child_of(parent) if parent
    hub
  end
end