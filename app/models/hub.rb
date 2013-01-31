class Hub < ActiveRecord::Base
  include Slugger
  include BaseSorts
  include BaseStates
  include TheSortableTree::Scopes

  # nested set
  acts_as_nested_set scope: :user
  attr_accessible :lft, :rgt, :parent_id, :depth

  # relations
  belongs_to :user
  has_many   :pages
  has_many   :posts
  has_many   :blogs
  has_many   :recipes
  has_many   :articles

  # scopes
  scope :of_, ->(type) { where(hub_type: type) }

  # WARNING: Can't mass-assign protected attributes for Hub: state, hub_type
  # for Model#create action => default at migration influence to create
  attr_accessible :title, :hub_type

  # validations
  validates_presence_of :user, :title, :hub_type
end
