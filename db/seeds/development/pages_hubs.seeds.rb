after 'development:posts' do
  root      = User.root
  pages_hub = Hub.friendly_where(:pages).first

  top_pages = root.hubs.create!(
    title: 'Верхние страницы',
    slug:  :top_pages,
    pubs_type: :pages,
    state: :published
  )
  bottom_pages = root.hubs.create!(
    title: 'Нижние страницы',
    slug: :bottom_pages,
    pubs_type: :pages,
    state: :published
  )

  top_pages.move_to_child_of    pages_hub
  bottom_pages.move_to_child_of pages_hub

  puts
  puts "Pages hubs created"
end