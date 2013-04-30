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

  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :notes
  has_many :recipes
  has_many :articles

  # scopes
  scope :of_, ->(type) { where(hub_type: type) }

  # validations
  validates_presence_of :user, :title, :hub_type

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
end
