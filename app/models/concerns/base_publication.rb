module BasePublication
  extend ActiveSupport::Concern

  included do
    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods
    include CommonClassMethods
    include MainImageUploading
    include TheCommentsCommentable

    acts_as_taggable

    before_validation :define_user_via_hub, :define_hub_state, on: :create
    before_save       :prepare_content

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of   :user, :slug, :title
    validates_uniqueness_of :slug
  end

  def root_hub
    hub.root_hub
  end

  def update_attachment_fields att_name
    _self = self.class.find(self.id)

    %w[file_name content_type file_size updated_at].each do |field|
      field_name = "#{att_name}_#{field}"
      self.send "#{field_name}=", _self[field_name]
    end

    self
  end

  private

  def define_user_via_hub
    self.user = hub.user if hub && user.blank?
  end

  def define_hub_state
    self.hub_state = hub.state if hub
  end

  def to_textile txt
    RedCloth.new(txt.to_s).to_html
  end

  def tags_preparator tags_str
    tags_str.to_s
  end

  def prepare_content
    self.intro   = to_textile(raw_intro)
    self.content = to_textile(raw_content)

    # tags processing
    _tags = tags_preparator self.tag_list
    self.inline_tags = _tags

    if root_hub
      context = root_hub.slug
      self.set_tag_list_on(context, _tags)
    end
  end
end