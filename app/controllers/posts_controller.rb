class PostsController < ApplicationController
  include BasePostController

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :author, :keywords, :description, :copyright, :title, :raw_content, :content, :main_image_url, :state, :first_published_at)
  end
end