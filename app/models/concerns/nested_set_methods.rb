module NestedSetMethods
  extend ActiveSupport::Concern

  included do
    include TheSortableTree::Scopes
    acts_as_nested_set scope: :user
    # attr_accessible :lft, :rgt, :parent_id, :depth
  end
end