class Hub < ActiveRecord::Base
  include BaseSorts
  include BaseStates
    
  belongs_to :user

  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :recipes
  has_many :articles

  acts_as_nested_set scope: :user
  attr_accessible :lft, :rgt, :parent_id, :depth

  # Scopes
  scope :of_, ->(type) { where(hub_type: type) }

  # Validations
  validates_presence_of :user, :title, :hub_type
end
