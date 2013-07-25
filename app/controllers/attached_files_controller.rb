class AttachedFilesController < ApplicationController
  include AttachedFilesActions
  include TheSortableTreeController::Rebuild

  before_action :find_storage, only: [:create, :delete_main_image]
  
  def delete_main_image
    @storage.destroy_main_image!
    redirect_to request.referer,
                notice: "Main image was successfully destroyed"
  end

  private

  def find_storage
    id    = params[:storage_id]
    klass = params[:storage_type].constantize
    @storage = klass.friendly_first(id)
  end
end