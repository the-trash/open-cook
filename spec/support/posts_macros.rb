module PostsMacros
  class << self
    def post_set_for hub
      5.times { FactoryGirl.create(:post, hub: hub, state: :published) }
      7.times { FactoryGirl.create(:post, hub: hub)                    }
    end

    def create_basic_articles
      hub = Hub.friendly_first(:articles)
      post_set_for(hub)
    end

    def create_basic_videos
      hub = Hub.friendly_first(:videos)
      post_set_for(hub)
    end

    def create_basic_blogs
      hub = Hub.friendly_first(:blogs)
      post_set_for(hub)
    end
  end
end