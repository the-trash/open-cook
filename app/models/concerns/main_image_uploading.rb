module MainImageUploading
  extend ActiveSupport::Concern
  include StorageImageProcessing

  included do
    attr_accessor :need_to_process_main_image
    before_save   :need_to_process_main_image?
    before_save   :generate_main_image_file_name, if: ->{ main_image? }
    after_commit  :build_main_image_variants

    has_attached_file :main_image,
                      default_url: "/default_images/main_image/:style/missing.jpg",
                      path:        ":rails_root/public/system/storages/:klass/:id/main_image/:style/:filename",
                      url:         "/system/storages/:klass/:id/main_image/:style/:filename"

    validates_attachment_size :main_image,
      in: 10.bytes..5.megabytes,
      message: "File size",
      if: ->{ main_image? }
      #I18n.translate('the_storages.validation.main_image_file_size')

    validates_attachment_content_type :main_image,
      content_type: AttachedFile::IMAGE_CONTENT_TYPES,
      message: 'file type is not allowed (only jpeg/png/gif images)'
  end

  def need_to_process_main_image?
    if main_image_updated_at_changed?
      self.need_to_process_main_image = true
    end
  end

  def generate_main_image_file_name
    attachment = self.main_image
    file_name  = attachment.instance_read(:file_name)
    file_name  = TheStorages.slugged_file_name(file_name)
    attachment.instance_write :file_name, file_name
  end

  def build_main_image_variants
    if need_to_process_main_image
      src     = main_image.path
      base    = main_image.path :base
      preview = main_image.path :preview

      # src     = main_image.path
      # base    = main_image.path :base
      # preview = main_image.path :preview
      # FileUtils.rm([src, base, preview], force: true)

      prepare_image(src, src, 1024)
      prepare_image(src, base, 300)
      build_square_image(src, preview, 100)
    end
  end
end