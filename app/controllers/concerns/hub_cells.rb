module HubCells
  extend ActiveSupport::Concern

  def initialize_hubs_selector id=nil, klass=nil, pub_type=nil
    @root_hub      = Hub.with_title(pub_type)
    @selector_hubs = @root_hub.try(:children)
    @selected_hub  = klass.constantize.find(id).try(:hub) if !id.blank? && !klass.blank?
  end
end