after 'development:recipes_hubs' do
  recipes_hub = Hub.friendly_where(:recipes).first
  recipes_hub.children.each do |menu|
    2.times do
      user = User.all.sample

      2.times do
        post = user.posts.create!(
          hub: menu,
          title: "#{menu.title}: " + Faker::Lorem.sentence,
          raw_intro: Faker::Lorem.paragraphs(2).join,
          raw_content: Faker::Lorem.paragraphs(3).join
        )
        post.send("to_#{ %w[draft published deleted].sample }")
        print '.'
      end
    end
  end

  puts
  puts "Recipes created"
end