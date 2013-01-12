module BaseStates
  extend ActiveSupport::Concern

  included do
    default_scope     where(state: :published)

    scope :draft,     where(state: :draft)
    scope :published, where(state: :published)
    scope :deleted,   where(state: :deleted)
  end
end