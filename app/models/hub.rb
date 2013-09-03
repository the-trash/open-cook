class Hub < ActiveRecord::Base
  include BasePublication 
  
  # relations
  belongs_to :user

  has_many :pages
  has_many :posts

  # validations
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
end
