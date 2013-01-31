module BaseSorts
  extend ActiveSupport::Concern

  included do
    scope :fresh,  -> { where('created_at DESC') }
    scope :oldest, -> { order('created_at ASC')  }
  end

  # module ClassMethods
  # end
 
  # module InstanceMethods
  # end
end