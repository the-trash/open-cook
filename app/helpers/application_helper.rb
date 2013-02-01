module ApplicationHelper
  def index_url controller_name
    url_for(controller: controller_name)
  end

  def edit_url obj
    url_for(controller: obj.controller_name, action: :edit, id: obj)
  end

  def show_url obj
    url_for(controller: obj.controller_name, action: :show, id: obj)
  end
end
