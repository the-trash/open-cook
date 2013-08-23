# TheStorages.config.param_name => value

TheStorages.configure do |config|
  config.watermark_text = 'Open-Cook.ru'
  config.convert_path   = '/usr/bin/convert' # BSD: /usr/local/bin/

  config.watermark_font_path = "#{Rails.root.to_s}/vendor/fonts/georgia_italic.ttf"
  config.watermarks_path     = "#{Rails.root.to_s}/public/uploads/watermarks"

  config.original_larger_side = 1024
  config.base_larger_side     = 800
end