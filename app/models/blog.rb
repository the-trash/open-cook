class Blog < ActiveRecord::Base
  include BasePublication

  before_validation :define_blog_hub,           on: :create
  before_validation :define_hub_state_for_blog, on: :create

  def define_blog_hub
    self.hub = Hub.where(
      user: User.root,
      title: "#{Time.now.year}-#{Time.now.month}",
      hub_type: :blogs
    ).first_or_create
  end

  private

  def define_hub_state_for_blog
    define_hub_state
  end
end