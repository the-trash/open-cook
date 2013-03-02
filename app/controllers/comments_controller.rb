class CommentsController < ApplicationController
  include TheCommentsController::Base

  def index
    @comments = Comment.with_state(:draft, :published).page(params[:page])
    render template: "the_comments/index"
  end

  def my
    @comments = current_user.comments.with_state(:draft, :published).page(params[:page])
    render template: "the_comments/manage"
  end

  def incoming
    @comments = current_user.comcoms.with_state(:draft, :published).page(params[:page])
    render template: "the_comments/manage"
  end
end