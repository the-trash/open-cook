# encoding: UTF-8
after 'development:hubs' do
  recipes_hub = Hub.friendly_where(:recipes).first

  [
    "Блины",
    "Интервью",
    "Статьи",
    "Детские рецепты Марии Панковой",
    "Открытая кухня Ольги Космос",
    "Заготовки",
    "Супы",
    "На второе",
    "Салаты",
    "Рыба",
    "Гарниры",
    "Овощи",
    "Вкусняшки к чаю",
    "Кухня мужика",
    "Напитки",
    "Птица с подворья",
    "К завтраку",
    "Закуски",
    "Ликеры и Сиропы",
    "Выпечка несладкая",
    "Соусы, дипы",
    "Десерты",
    "Кремы"
  ].each do |title|
    hub = User.root.hubs.create!(title: title)
    hub.to_published
    hub.move_to_child_of(recipes_hub)
    print '.'
  end

  puts
  puts "Recipe hubs created"
end