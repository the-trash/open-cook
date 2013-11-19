# encoding: UTF-8
require "#{Rails.root}/db/seeds/support/hubs_build"

after 'development:posts' do
  HubsBuild.create_system_hub(:system_pages, 'Системные страницы', :pages)
  puts "Pages hubs created"
end