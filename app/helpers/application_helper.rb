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
  # Post.model_name.human              => activerecord.models.post
  # Post.human_attribute_name('title') => activerecord.attributes.post.title
  def error_messages_for obj
    if obj.errors.any?
      lis = obj.errors.map do |name, msgs|
        name = obj.class.human_attribute_name(name)
        if msgs.is_a?(Array)
          msgs.map{|msg| "<li><b>#{name}:</b> #{msg}</li>"}.join()
        else
          "<li><b>#{name}:</b> #{msgs}</li>"
        end
      end.join()

      raw "<div id='error_explanation' class='error_explanation'>
        <h2>При сохранении возникли следующие ошибки:</h2>
        <ul>#{lis}</ul>
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