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

  def publication_types
    %w[ posts blogs recipes videos articles ].collect{ |type| [ t("publication.#{type}"), type ] }
  end
end