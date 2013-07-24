module MainImageUploading
  extend ActiveSupport::Concern
  include StorageImageProcessing

  included do
    # attr_accessor :need_to_process_main_image
    # before_save   :need_to_process_main_image?
    # before_save   :generate_main_image_file_name, if: ->{ main_image? }
    # after_commit  :build_main_image_variants

    has_attached_file :main_image,
                      default_url: "/default_images/main_image/:style/missing.jpg",
                      path:        ":rails_root/public/system/storages/:klass/:id/main_image/:style/:filename",
                      url:         "/system/storages/:klass/:id/main_image/:style/:filename"

    validates_attachment :main_image,
      :content_type => {
        content_type: AttachedFile::IMAGE_CONTENT_TYPES,
        message: "It's should be image"
      }

    # validates_with AttachmentContentTypeValidator :main_image,
    #   in: 2.megabytes..5.megabytes,
    #   message: I18n.translate('post.validation.main_image_file_size'),
    #   if: ->{ main_image? }

    # validates_attachment_size :main_image,
    #   in: 2.megabytes..5.megabytes,
    #   message: I18n.translate('post.validation.main_image_file_size'),
    #   if: ->{ main_image? }

    # validates_attachment_content_type :main_image,
    #   content_type: AttachedFile::IMAGE_CONTENT_TYPES,
    #   message: '11111' #I18n.translate('post.validation.main_image_file_type')
  end

  def need_to_process_main_image?
    self.need_to_process_main_image = true if main_image_updated_at_changed?
  end

  def generate_main_image_file_name
    attachment = self.main_image
    file_name  = attachment.instance_read(:file_name)
    file_name  = "main-image." + TheStorages.file_ext(file_name)
    attachment.instance_write :file_name, file_name
  end

  def build_main_image_variants
    if need_to_process_main_image
      src     = main_image.path
      base    = main_image.path :base
      preview = main_image.path :preview

      prepare_image(src, src, 1024)
      prepare_image(src, base, 300)
      build_square_image(src, preview, 100)
    end
  end

  def destroy_main_image!
    base    = main_image.path(:base).to_s
    preview = main_image.path(:preview).to_s
    FileUtils.rm([base, preview], force: true)
    main_image.destroy
    save!
  end
end