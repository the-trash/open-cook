class String
  def to_slug_param
    I18n::transliterate(self).gsub('_','-').parameterize('-')
  end
end