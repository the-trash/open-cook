module ActiveRecordExtension
  extend ActiveSupport::Concern

  def ctrl_name
    self.class.to_s.tableize
  end

  def show_path
    "/#{ctrl_name}/#{to_param}"
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtension)