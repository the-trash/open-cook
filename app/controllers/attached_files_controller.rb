class AttachedFilesController < ApplicationController  
  include AttachedFilesActions

  before_action :find_storage, only: [:create]

  private

  def find_storage
    id    = params[:storage_id]
    klass = params[:storage_type]
    @storage = klass.constantize.friendly_where(id).first
  end
end