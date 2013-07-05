module ApplicationHelper
  def model_name
    controller_name.singularize
  end

  def pub_type
    params[:pub_type] || model_name
  end

  def publication_states
    %w[ draft published ].collect{ |state| [ t("publication.#{state}"), state ] }
  end

  def post_types
    %w[ posts blogs recipes videos articles pages ].collect{ |type| [ t("publication.#{type}"), type ] }
  end

  # Error mesages
  def error_messages_for obj
    if @post.errors.any?
      lis = @post.errors.full_messages.map do |msg|
        "<li>#{msg}</li>"
      end.join

      raw "<div id='error_explanation'> 
        <h2>#{pluralize(obj.errors.count, "error")} prohibited this post from being saved:</h2>
        <ul>
          #{lis}
        </ul>
      </div>"
    end
  end

  # Flash Messages
  def flash_class(level)
    case level
      when :notice then "info"
      when :error then  "error"
      when :alert then  "warning"
    end
  end  
end