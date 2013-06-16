class Hub < ActiveRecord::Base
  include BasePublication 
  
  # relations
  belongs_to :user

  has_many :pages
  has_many :posts

  # scopes
  scope :of_, ->(type) { where(pub_type: type) }

  # validations
  validates_presence_of :user, :title
  validates :title,    uniqueness: { scope: :user }

  def same_hubs
    Hub.where(pub_type: pub_type)
  end

end
