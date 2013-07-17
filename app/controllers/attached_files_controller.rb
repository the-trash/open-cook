class AttachedFilesController < ApplicationController
  include AttachedFilesActions
  include TheSortableTreeController::Rebuild

  before_action :find_storage, only: [:create]

  private

  def find_storage
    id    = params[:storage_id]
    klass = params[:storage_type].constantize
    @storage = klass.friendly_where(id).first
  end
end