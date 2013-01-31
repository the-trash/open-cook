module BasePublication
  extend ActiveSupport::Concern

  included do
    include Slugger
    include BaseSorts
    include BaseStates
    include TheSortableTree::Scopes

    # nested set
    acts_as_nested_set scope: :user
    attr_accessible :lft, :rgt, :parent_id, :depth

    # relations
    belongs_to :user
    belongs_to :hub

    attr_accessible :user, :hub, :title, :raw_content

    validates_presence_of :user, :hub, :title
  end
end