# friendly_id h11149+menu-10-u-5  # uniq
# short_id    h11149              # uniq
# id          50                  # uniq

module TheFriendlyId
  extend ActiveSupport::Concern

  SEPARATOR = "+"

  included do
    def to_param; self.friendly_id end

    validates_presence_of :short_id, :friendly_id

    before_validation :build_short_id
    before_validation :build_slugs

    def build_short_id
      return unless self.short_id.blank?
      klass  = self.class.to_s.downcase.to_sym

      prefix = {
        hub:     :h,
        page:    :p,
        post:    :pt,
        blog:    :b,
        recipe:  :rc,
        article: :a
      }[klass]

      prefix  ||= 'x'
      rnd_num   = 9999

      # build short_id
      short_id = [prefix, rand(rnd_num)].join

      # rebuild if find identically short_id
      while self.class.where(short_id: short_id).first
        puts "IDENTICAL SHORT_ID => rebuild"
        short_id = [prefix, rand(rnd_num)].join
      end

      # set short_id 
      self.short_id = short_id
    end

    def build_slugs
      unless self.title.blank?
        text_name        = Russian::translit(self.title).parameterize
        self.friendly_id = [self.short_id, text_name].join TheFriendlyId::SEPARATOR
      end
    end

  end

  module ClassMethods
    def friendly_where id
      if Regexp.new("\\#{TheFriendlyId::SEPARATOR}") =~ id
        where(friendly_id: id)
      else
        id.size == id.to_i.to_s.size ? where(id: id) : where(short_id: id)
      end
    end
  end
end