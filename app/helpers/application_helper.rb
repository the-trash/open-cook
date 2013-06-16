module ApplicationHelper
  def model_name
    controller_name.singularize
  end

  def publication_states
    %w[ draft published ].collect{ |state| [ t("publication.#{state}"), state ] }
  end
end