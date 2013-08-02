# encoding: UTF-8
module HubsBuild
  def self.create_system_hub slug, title, type
    User.root.hubs.create!(
      slug:  slug,
      title: title,
      pubs_type: type,
      state: :published
    )
  end
end

after 'development:users' do
  HubsBuild.create_system_hub(:pages,      'Страницы', :pages)
  HubsBuild.create_system_hub(:interviews, 'Интервью', :posts)
  HubsBuild.create_system_hub(:articles,   'Статьи',   :posts)
  HubsBuild.create_system_hub(:recipes,    'Рецепты',  :posts)
  HubsBuild.create_system_hub(:videos,     'Видео',    :posts)
  HubsBuild.create_system_hub(:blogs,      'Блоги',    :posts)

  puts "Hubs created"
end