class CommentsController < ApplicationController
  include TheCommentsController::Base

  def index
    @comments = current_user.comments.with_state(:draft, :published).page(params[:page])
  end
end