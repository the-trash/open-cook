module BasePublication
  extend ActiveSupport::Concern

  included do
    include TheCommentsCommentable

    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods

    before_save :prepare_content
    after_save  :update_hub_counters

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of :user, :hub, :title
  end

  def controller_name
    self.class.to_s.tableize
  end

  def show_path
    "/#{controller_name}/#{to_param}"
  end

  private

  def update_hub_counters
    hub.recalculate_publications_counters! if hub
  end

  def prepare_content
    self.intro   = "<i>#{self.raw_intro}</i>"
    self.content = "<b>#{self.raw_content}</b>"
  end
end