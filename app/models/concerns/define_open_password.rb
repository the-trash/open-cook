module DefineOpenPassword
  extend ActiveSupport::Concern

  included do
    before_save   :define_open_password
    before_update :define_password

    private

    def define_open_password
      self.open_password = self.password
    end

    def define_password
      self.password = self.open_password if self.password.blank?
    end
  end
end