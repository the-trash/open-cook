class Blog < ActiveRecord::Base
  include BasePublication

  before_validation :define_blog_hub, on: :create

  def define_blog_hub
    self.hub = Hub.where(
      user: User.root,
      title: "#{Time.now.year}-#{Time.now.month}",
      hub_type: self.class.to_s.tableize
    ).first_or_create
  end
end