module DefaultRole
  extend ActiveSupport::Concern

  included do
    before_create :set_default_role

    private

    def set_default_role
      self.role = Role.where(:name => :user).first
    end
  end
end