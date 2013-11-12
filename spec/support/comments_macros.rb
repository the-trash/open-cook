module CommentsMacros
  class << self
    # CommentsMacros.create_comments_for(@post, @user)
    def create_comments_for obj, owner = nil
      3.times do
        obj.comments.create!(
          user:        owner,
          commentable: obj,
          title:       Faker::Lorem.sentence,
          contacts:    Faker::Lorem.sentence,
          raw_content: Faker::Lorem.paragraphs(4).join
        )
      end
    end
  end
end