class Hub < ActiveRecord::Base
  include BasePublication 
  
  belongs_to :user

  has_many :pages
  has_many :posts

  validates_presence_of :user, :title, :slug
  validates :slug, uniqueness: true

  scope :of_, ->(type) { where(pubs_type: type) }

  class << self
    def with_slug name
      where(slug: name.to_s.to_slug_param).first
    end

    def top_sections
      tops = with_slug(:top_sections)
      tops ? tops.children.where(pubs_type: :posts).published_set : none
    end
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

  def recalculate_pubs_counters!
    update({
      pubs_count_published: self.pubs.with_state(:published).count,
      pubs_count_draft:     self.pubs.with_state(:draft).count,
      pubs_count_deleted:   self.pubs.with_state(:deleted).count
    })
  end  
end
