module ModeratorStates
  extend ActiveSupport::Concern

  # not_approved | approved
  included do

    state_machine :moderation_state, namespace: :moderation, :initial => :unmoderated do
      event :to_unmoderated do 
        transition all => :unmoderated
      end

      event :to_moderated do
        transition all => :moderated
      end

      event :to_blocked do
        transition all => :blocked
      end

      after_transition any => :blocked do |obj|
        p "transition => blocked - cleanup moderator notes"
      end
    end

  end
end