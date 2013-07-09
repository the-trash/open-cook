module HubCells
  extend ActiveSupport::Concern

  def initialize_hubs_selector post
    @selector_hubs = Hub.sections
    @selected_hub  = post.try(:hub)
  end
end