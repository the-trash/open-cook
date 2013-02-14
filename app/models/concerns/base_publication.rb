module BasePublication
  extend ActiveSupport::Concern

  included do
    include BaseSorts
    include BaseStates
    include TheFriendlyId
    include NestedSetMethods

    before_save :prepare_content

    paginates_per 25

    def controller_name
      self.class.to_s.tableize
    end

    def show_path
      "/#{controller_name}/#{to_param}"
    end

    # relations
    belongs_to :user
    belongs_to :hub

    attr_accessible :user, :hub, :title, :raw_intro, :raw_content
    validates_presence_of :user, :hub, :title

    # comments
    has_many :comments, as: :commentable
    # attr_accessible :total_comments_count, :draft_comments_count, :published_comments_count, :deleted_comments_count

    private

    def prepare_content
      self.intro   = "<i>#{self.raw_intro}</i>"
      self.content = "<b>#{self.raw_content}</b>"
    end
  end
end