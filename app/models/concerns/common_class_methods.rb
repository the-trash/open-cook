module CommonClassMethods
  extend ActiveSupport::Concern

  module ClassMethods
    def with_title name
      where(title: name).first
    end

    def with_users 
      includes(:user)
    end

    def published
      with_states(:published)
    end

    def published_set
      published.nested_set
    end

    def published_rset
      published.reversed_nested_set
    end

    def published_with_user
      published.with_users
    end

    def for_manage
      with_states(:draft, :published)
    end

    def for_manage_set
      for_manage.nested_set
    end

    def for_manage_rset
      for_manage.reversed_nested_set
    end

    def pagination params
      page(params[:page]).per(params[:per_page])
    end
  end
end