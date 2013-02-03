module DefaultRole
  extend ActiveSupport::Concern

  included do
    validates :role, presence: true
    before_validation :set_default_role, on: :create

    private

    def set_default_role
      self.role = Role.where(name: :user).first
    end
  end
end