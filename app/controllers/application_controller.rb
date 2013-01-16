class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons

  before_action -> { @user = User.first }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
