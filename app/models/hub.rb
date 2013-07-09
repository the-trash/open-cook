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
  
  def self.sections
    roots.of_(:posts).with_state(:published)
  end

  def pubs
    send(pubs_type)
  end

  # def self.same_hubs
  #   Hub.where(pubs_type: pub_type)
  # end
end
