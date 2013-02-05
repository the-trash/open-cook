module TheRoleAddons
  extend ActiveSupport::Concern

  included do
    def access_denied
      render :text => 'access_denied: requires an role' and return
    end

    alias_method :login_required,     :require_login
    alias_method :role_access_denied, :access_denied
  end
end