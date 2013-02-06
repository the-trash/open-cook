class Hub < ActiveRecord::Base
  include BaseSorts
  include BaseStates
  include TheFriendlyId
  include NestedSetMethods

  def controller_name
    self.class.to_s.tableize
  end
    
  # relations
  belongs_to :user

  has_many   :pages
  has_many   :posts
  has_many   :blogs
  has_many   :notes
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
