module ApplicationHelper
  def model_name
    controller_name.singularize
  end

  def pub_type
    params[:pub_type] || model_name
  end

  def publication_states
    %w[ draft published ].collect{ |state| [ t("pubs.states.#{state}"), state ] }
  end

  def hub_pubs_types
    %w[ posts pages ].collect{ |type| [ t("hubs.pubs_types.#{type}"), type ] }
  end  
end