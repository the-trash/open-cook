module BasePublication
  extend ActiveSupport::Concern

  included do
    include BaseSorts
    include BaseStates
    include ActAsStorage
    include TheFriendlyId
    include NestedSetMethods
    include CommonClassMethods
    include TheCommentsCommentable

    before_validation :define_user_via_hub, :define_hub_state, on: :create
    before_save       :prepare_content

    paginates_per 25

    # relations
    belongs_to :user
    belongs_to :hub

    validates_presence_of   :user, :slug
    validates_uniqueness_of :slug

    # MAIN IMAGE
    def attachment_exists? name
      !send(name).blank?
    end

    before_validation :generate_main_image_file_name,
      if: ->{ attachment_exists?(:main_image) }

    def generate_main_image_file_name
      attachment = self.main_image
      file_name  = attachment.instance_read(:file_name)
      file_name  = TheStorages.slugged_file_name(file_name)
      attachment.instance_write :file_name, file_name
    end

    has_attached_file :main_image,
                      default_url: ":rails_root/public/system/uploads/default/main_image/:style/missing.jpg",
                      path:        ":rails_root/public/system/storages/:klass/:id/main_image/:style/:filename",
                      url:         "/system/storages/:klass/:id/main_image/:style/:filename"

    validates_attachment_size :main_image,
      in: 10.bytes..5.megabytes,
      message: "File size", #I18n.translate('the_storages.validation.main_image_file_size')
      if: ->{ attachment_exists?(:main_image) }
  end

  private

  def define_user_via_hub
    self.user = hub.user if hub && user.blank?
  end

  def define_hub_state
    self.hub_state = hub.state if hub
  end

  def prepare_content
    self.intro   = "<i>#{self.raw_intro}</i>"
    self.content = "<b>#{self.raw_content}</b>"
  end
end