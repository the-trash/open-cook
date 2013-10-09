module HubCells
  extend ActiveSupport::Concern

  def build_hubs_selector post
    @selector_hubs = Hub.sections unless post.try(:hub)
  end
end