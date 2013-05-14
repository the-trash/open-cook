module BasePublication
  extend ActiveSupport::Concern

  module ClassMethods
    def active_publications
      includes(:user).with_states(:published).where(hub_state: :published)
    end
  end

  included do
    include TheCommentsCommentable

    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods

    before_validation :define_user_via_hub, :define_hub_state, on: :create
    before_save       :prepare_content
    after_save        :update_hub_counters

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of :user, :hub, :title
    validates_uniqueness_of :slug, unless: ->(pub) { pub.slug.blank? }
  end

  def controller_name
    self.class.to_s.tableize
  end

  def show_path
    "/#{controller_name}/#{to_param}"
  end

  private

  def define_user_via_hub
    self.user = hub.user if user.blank?
  end

  def define_hub_state
    self.hub_state = hub.state if hub
  end

  def update_hub_counters
    hub.recalculate_publications_counters!
  end

  def prepare_content
    self.intro   = "<i>#{self.raw_intro}</i>"
    self.content = "<b>#{self.raw_content}</b>"
  end
end