class AttachedFilesController < ApplicationController
  include AttachedFilesActions
  include TheSortableTreeController::Rebuild

  before_action :find_storage, only: %w[
    create
    delete_main_image
    main_image_to_left
    main_image_to_right
    crop_image_for_preview
  ]

  # before_action :check_access
  
  def crop_image_for_preview
    @storage.crop_for_preview!(
      params[:x], params[:y],
      params[:w], params[:h],
      params[:img_w])

    redirect_to request.referer,
                notice: t('attached_files.preview_rebuilded')
  end

  def main_image_to_left
    @storage.main_image_to_left!
    redirect_to request.referer,
                notice: t('attached_files.image_rotated_on_left')
  end

  def main_image_to_right
    @storage.main_image_to_right!
    redirect_to request.referer,
                notice: t('attached_files.image_rotated_on_right')
  end

  def delete_main_image
    @storage.destroy_main_image!
    redirect_to request.referer,
                notice: t('attached_files.main_image_deleted')
  end

  private

  def find_storage
    id    = params[:storage_id]
    klass = params[:storage_type].constantize
    @storage = klass.friendly_first(id)
  end
end