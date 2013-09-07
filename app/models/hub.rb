class Hub < ActiveRecord::Base
  include BasePublication 
  
  belongs_to :user

  has_many :pages
  has_many :posts

  validates_presence_of :user, :title, :slug
  validates :slug, uniqueness: true

  scope :of_, ->(type) { where(pubs_type: type) }
  
  def self.sections pub_type
    roots.of_(pub_type).published_set
  end

  def pubs
    send(pubs_type)
  end

  def pubs_klass
    pubs_type.classify.constantize
  end

  def self_and_children_pubs sub_hubs
    ids = sub_hubs.pluck(:id) | [id]
    pubs_klass.where(hub_id: ids)
  end

  def root_hub
    self_and_ancestors.published_set.first
  end

  def current_level_hubs
    root? ? Hub.none : self_and_siblings.published_set
  end
end
