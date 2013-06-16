module ActiveRecordExtension
  extend ActiveSupport::Concern

  def controller_name
    self.class.to_s.tableize
  end

  def show_path
    "/#{controller_name}/#{to_param}"
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)