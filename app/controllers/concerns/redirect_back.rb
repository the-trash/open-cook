module RedirectBack
  extend ActiveSupport::Concern

  included do

    def redirect_back_or(path = '/')
      redirect_to :back
      rescue ActionController::RedirectBackError
      redirect_to path
    end

  end
end