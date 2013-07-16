# TheStorages.config.param_name => value

TheStorages.configure do |config|
  config.watermark_text = 'https://github.com/the-teacher'
  config.convert_path   = '/usr/bin/convert' # BSD: /usr/local/bin/

  config.watermark_font_path  = nil

  config.original_larger_side = 1024
  config.main_larger_side     = 800
end