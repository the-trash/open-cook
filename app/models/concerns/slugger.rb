# friendly_id h11149+menu-10-u-5  # uniq
# slug_id     menu-10-u-5         # not unique => not for basic search
# short_id    h11149              # uniq
# id          50                  # uniq

module Slugger
  extend ActiveSupport::Concern

  SEPARATOR = "+"

  included do
    def to_param; self.friendly_id end

    validates_presence_of :slug_id, :short_id, :friendly_id

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
      rnd_num   = 99999

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
        self.slug_id     = Russian::translit(self.title).parameterize 
        self.friendly_id = [self.short_id, self.slug_id].join Slugger::SEPARATOR
      end
    end

  end

  module ClassMethods
    def slug_where id
      if Regexp.new("\\#{Slugger::SEPARATOR}") =~ id
        where(friendly_id: id)
      else
        id.size == id.to_i.to_s.size ? where(id: id) : where(short_id: id)
      end
    end

  end
end