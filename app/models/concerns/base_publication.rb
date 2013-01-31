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

    validates_presence_of :user, :hub, :title
    attr_accessible :user, :hub, :title, :raw_content

    # attr_accessible :name
    # attr_protected  :admin

    # def to_param; self.slug_id end

    # short_id    => p1345
    # slug_id     => my-first-blog-post
    # friendly_id => short_id + slug_id = p1345--my-first-blog-post
    # validates_presence_of :slug_id, :short_id, :friendly_id
  end
end