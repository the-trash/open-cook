# encoding: UTF-8
after 'development:pages_hubs' do
  p "Create Pages"

  root         = User.first
  system_pages = Hub.with_slug(:system_pages)

  #-----------------------------------
  # Top
  #-----------------------------------
  root.pages.create!(
    hub: system_pages,
    title: 'О сайте',
    slug:  :about,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )

  #-----------------------------------
  # Bottom
  #-----------------------------------
  root.pages.create!(
    hub: system_pages,
    title: 'Правила сайта',
    slug:  :rules,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )
  root.pages.create!(
    hub: system_pages,
    title: 'Помощь',
    slug:  :help,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )
  root.pages.create!(
    hub: system_pages,
    title: 'Партнеры и друзья',
    slug:  :partners,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )
  root.pages.create!(
    hub: system_pages,
    title: 'Авторам',
    slug:  :authors,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )
  root.pages.create!(
    hub: system_pages,
    title: 'Контакты',
    slug:  :contacts,
    raw_content: Faker::Lorem.paragraphs(2).join,
    state: :published
  )

  puts "Base Pages Created"
end