module ActAsStorage
  extend ActiveSupport::Concern

  included do
    class_eval do
      has_many :uploaded_files, as: :storage

      def recalculate_files_data
        sum   = 0
        files = self.uploaded_files.active

        files.each{ |f| sum += f.file_file_size }
        self.files_size  = sum
        self.files_count = files.size
      end

      def recalculate_files_data_for_user
        user        = self.user
        storages    = user.storages.active | user.recipes.active | user.pages.active | user.articles.active
        files_size  = 0
        files_count = 0

        storages.each do |s|
          files_size  += s.files_size
          files_count += s.files_count
        end

        user.files_size  = files_size
        user.files_count = files_count
        user.save(:validation => false)
      end
      
      after_update  :recalculate_files_data_for_user
      after_destroy :recalculate_files_data_for_user
      before_update :recalculate_files_data
    end
  end
end