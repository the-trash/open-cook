module BasePublication
  extend ActiveSupport::Concern

  included do
    include BaseSorts
    include BaseStates
    include TheFriendlyId
    include NestedSetMethods

    # relations
    belongs_to :user
    belongs_to :hub

    attr_accessible :user, :hub, :title, :raw_content

    validates_presence_of :user, :hub, :title
  end
end