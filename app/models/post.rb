class Post < ActiveRecord::Base

  def to_param; self.slug_id; end

  belongs_to :user

  validates :user, presence: true

  # short_id    => p1345
  # slug_id     => my-first-blog-post
  # friendly_id => short_id + slug_id = p1345--my-first-blog-post
  validates_presence_of :slug_id, :short_id, :friendly_id
end
