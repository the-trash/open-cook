class User < ActiveRecord::Base
  authenticates_with_sorcery!
  include DefineOpenPassword

  include TheRoleUserModel
  
  include ActAsStorage
  include HasAttachedFiles

  include TheCommentsUser
  include TheCommentsCommentable

  def to_param; self.login end

  # Relations
  has_many :hubs
  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :notes
  has_many :recipes
  has_many :articles

  # validations
  before_validation :prepare_login, on: :create

  validates :login,    presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  class << self
    def root
      @@root ||= User.first
    end

    def create_admin!
      user = new(
        login: :admin,
        email: "admin@site.com",
        password: "qwerty",
        role: Role.with_name(:admin)
      )
      user.save!
      user
    end
  end

  def admin?
    self == User.root
  end

  # TheComments methods
  def comment_moderator? comment
    admin? || id == comment.holder_id
  end

  def commentable_title
    login
  end

  def commentable_path
    [self.class.to_s.tableize, login].join('/')
  end

  def role_name
    role.try(:name)
  end

  def recalculate_all_attached_files!
    # Recalculate all user counters here
  end

  # Select an available hubs
  # 
  # Admin has: all + for_manage hubs
  #
  # Any User has: hubs defined in his TheRole
  # with section "available_hubs"
  def available_hubs ctrl_name = nil
    scope = ctrl_name.blank? ? :all : [:of_, ctrl_name]

    return Hub.send(*scope).for_manage if admin?
    
    section = role.to_hash.try(:[], 'available_hubs')
    return Hub.none unless section

    keys = section.select{|k, v| v == true }.keys
    keys.map!{|item| item.to_slug_param }
    Hub.friendly_where(keys).published_set.send(*scope)
  end

  private

  def prepare_login
    self.login = self.login.to_s.to_slug_param
  end
end
