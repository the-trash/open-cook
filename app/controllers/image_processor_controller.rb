class ImageProcessorController < ApplicationController
  def rotate_left
    attached_file = AttachedFile.where(id: params[:id]).first
    attached_file.rotate_left
    render text: :rotate_left_ok
  end

  def rotate_right
    attached_file = AttachedFile.where(id: params[:id]).first
    attached_file.rotate_right
    render text: :rotate_right_ok
  end
end