class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons

  # @user - to show
  # @root - root user
  # current_user - logined user
  before_action -> { @root = User.first }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
