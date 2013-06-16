class Hub < ActiveRecord::Base
  include BaseSorts
  include BaseStates
  include ActAsStorage
  include TheFriendlyId
  include NestedSetMethods

  before_save :update_publications_hub_state!
    
  # relations
  belongs_to :user

  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :notes
  has_many :recipes
  has_many :articles

  # scopes
  scope :of_, ->(type) { where(hub_type: type) }

  # validations
  validates_presence_of :user, :title, :hub_type, :hub_name
  validates :title,    uniqueness: { scope: :user }
  validates :hub_name, uniqueness: { scope: :user }

  def publications
    send hub_type
  end

  def same_hubs
    self.class.where(hub_type: hub_type)
  end

  def recalculate_publications_counters!
    self.draft_publications_count     = publications.with_state(:draft).count
    self.published_publications_count = publications.with_state(:published).count
    self.deleted_publications_count   = publications.with_state(:deleted).count
    save!
  end

  def update_publications_hub_state!
    publications.update_all({ hub_state: self.state }) if state_changed?
  end
end
