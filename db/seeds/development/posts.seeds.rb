after 'development:recipes' do
  %w[ blogs videos articles interviews].each do |name|
    puts " --- #{name}"

    3.times do
      user     = User.all.sample
      holder_hub = Hub.friendly_where(name).first

      3.times do
        post = user.posts.create!(
          hub: holder_hub,
          title: "#{name}: " + Faker::Lorem.sentence,
          raw_intro: Faker::Lorem.paragraphs(2).join,
          raw_content: Faker::Lorem.paragraphs(3).join
        )
        post.send("to_#{ %w[draft published deleted].sample }")
        print '.'
      end
    end

    puts
  end

  puts 'Posts created'
end