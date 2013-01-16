module SorceryAddons
  extend ActiveSupport::Concern

  # Example of Sorcery login require
  # before_action :require_login, :only => :secret
  # skip_before_filter :require_login, only: [:index]

  included do
    protected

    def not_authenticated
      redirect_to login_url, :alert => "First login to access this page."
    end

  end
end