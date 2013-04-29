module BasePublication
  extend ActiveSupport::Concern

  included do
    include TheCommentsCommentable

    include BaseSorts
    include BaseStates
    include TheFriendlyId
    include NestedSetMethods

    before_save :prepare_content

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of :user, :hub, :title

    def controller_name
      self.class.to_s.tableize
    end

    def show_path
      "/#{controller_name}/#{to_param}"
    end

    private

    def prepare_content
      self.intro   = "<i>#{self.raw_intro}</i>"
      self.content = "<b>#{self.raw_content}</b>"
    end
  end
end