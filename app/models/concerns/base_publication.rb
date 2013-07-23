module BasePublication
  extend ActiveSupport::Concern

  included do
    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods
    include CommonClassMethods
    include MainImageUploading
    include TheCommentsCommentable

    before_validation :define_user_via_hub, :define_hub_state, on: :create
    before_save       :prepare_content

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of   :user, :slug
    validates_uniqueness_of :slug

    # MAIN IMAGE
    def attachment_exists? name
      !send(name).blank?
    end
  end

  private

  def define_user_via_hub
    self.user = hub.user if hub && user.blank?
  end

  def define_hub_state
    self.hub_state = hub.state if hub
  end

  def prepare_content
    self.intro   = "<i>#{self.raw_intro}</i>"
    self.content = "<b>#{self.raw_content}</b>"
  end
end