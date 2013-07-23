module MainImageUploading
  extend ActiveSupport::Concern

  # attr_accessor :main_image_processing_flag
  # after_commit  :main_image_processing

  included do
    before_validation :generate_main_image_file_name,
      if: ->{ attachment_exists?(:main_image) }

    has_attached_file :main_image,
                      default_url: ":rails_root/public/system/default/main_image/:style/missing.jpg",
                      path:        ":rails_root/public/system/storages/:klass/:id/main_image/:style/:filename",
                      url:         "/system/storages/:klass/:id/main_image/:style/:filename"

    validates_attachment_size :main_image,
      in: 10.bytes..5.megabytes,
      message: "File size", #I18n.translate('the_storages.validation.main_image_file_size')
      if: ->{ attachment_exists?(:main_image) }
  end

  def main_image_processing

  end

  def generate_main_image_file_name
    attachment = self.main_image
    file_name  = attachment.instance_read(:file_name)
    file_name  = TheStorages.slugged_file_name(file_name)
    attachment.instance_write :file_name, file_name
  end
end