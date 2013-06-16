module BasePublication
  extend ActiveSupport::Concern

  module ClassMethods
    def active_pubs
      includes(:user).with_states(:published).where(hub_state: :published)
    end

    def with_name name
      where(title: name).first
    end

    def with_pub_type type
      type ? where(pub_type: type) : all
    end
  end

  included do
    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods
    include TheCommentsCommentable

    before_validation :define_user_via_hub, :define_hub_state, on: :create
    before_save       :prepare_content

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of   :user, :hub, :title, :pub_type
    validates_uniqueness_of :slug, unless: ->(pub) { pub.slug.blank? }
  end

  private

  def define_user_via_hub
    self.user = hub.user if user.blank?
  end

  def define_hub_state
    self.hub_state = hub.state if hub
  end

  def prepare_content
    self.intro   = "<i>#{self.raw_intro}</i>"
    self.content = "<b>#{self.raw_content}</b>"
  end
end