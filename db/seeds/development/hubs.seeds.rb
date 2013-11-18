# encoding: UTF-8
require "#{Rails.root}/db/seeds/support/hubs_build"

after 'development:users' do
  system_hub = HubsBuild.create_system_hub(:system_hubs, 'Системные разделы', :pages)

  HubsBuild.create_system_hub(:interviews, 'Интервью', :posts, system_hub)
  HubsBuild.create_system_hub(:articles,   'Статьи',   :posts, system_hub)
  HubsBuild.create_system_hub(:recipes,    'Рецепты',  :posts, system_hub)
  HubsBuild.create_system_hub(:videos,     'Видео',    :posts, system_hub)
  HubsBuild.create_system_hub(:blogs,      'Блоги',    :posts, system_hub)

  puts "Hubs created"
end