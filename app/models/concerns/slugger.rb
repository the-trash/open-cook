module Slugger
  extend ActiveSupport::Concern

  included do
    before_validation :build_short_id, on: :create
    before_save       :build_slugs

    def slug_separator; "+" ;end

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

      # build short_id
      short_id = [prefix, rand(99999)].join

      # rebuild if find identically short_id
      while self.class.to_s.camelize.constantize.where(short_id: short_id).first
        short_id = [prefix, rand(99999)].join
      end

      # set short_id 
      self.short_id = short_id
    end

    def build_slugs
      unless self.title.blank?
        self.slug_id     = Russian::translit(self.title).parameterize 
        self.friendly_id = [self.short_id, self.slug_id].join slug_separator
      end
    end

  end
end