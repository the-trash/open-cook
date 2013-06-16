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
end