class Hub < ActiveRecord::Base
  belongs_to :user

  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :recipes
  has_many :articles

  # Scopes
  scope :of_, ->(type) { where(state: :published, hub_type: type) }

  # Validations
  validates_presence_of :user, :title, :hub_type
end
