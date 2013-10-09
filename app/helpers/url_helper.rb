module UrlHelper
  def index_url controller_name
    url_for(controller: controller_name)
  end

  def edit_url obj
    url_for(controller: obj.ctrl_name, action: :edit, id: obj)
  end

  def show_url obj, anchor = nil
    url_for(controller: obj.ctrl_name, action: :show, id: obj, anchor: anchor)
  end
end