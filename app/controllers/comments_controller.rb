class CommentsController < ApplicationController
  # before_action :owner_required,     only: [:my, :incoming, :trash]
  # before_action :moderator_required, only: [:update, :to_published, :to_draft, :to_spam, :to_trash]

  include TheCommentsController::Base

  # Public methods
  # [:index, :create]

  # Application side methods => Overwrite following default methods if it's need
  # Methods for current user
  # [:my, :incoming, :trash]

  # You must protect following methods. 
  # Only comments moderator (holder or admin) can invoke following actions
  # [:edit, :update, :to_published, :to_draft, :to_spam, :to_trash]
end