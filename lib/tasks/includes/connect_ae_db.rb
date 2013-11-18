# DB_MOVING = true

CONNECTION_PARAMS_AE = {
  :adapter  => "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "123123",
  :database => "art_electronics_dev",
  :encoding => "utf8"
}

# AE DataBases
class AE_ArchiveNumber < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :archive_numbers
end

class AE_Article < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :articles
end

class AE_Author < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :authors
end

class AE_Banner < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :banners
end

class AE_BannerCategory < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :banners_categories
end

class AE_Blog < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :blogs
end

class AE_Category < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :categories
end

class AE_Comment < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :comments
end

class AE_CommentsSubscriber < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :comments_subscribers
end

class AE_Favorite < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :favorites
end

class AE_Message < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :messages
end

class AE_News < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :news
end

class AE_Offer < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :offers
end

class AE_Partner < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :partners
end

class AE_Settings < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :settings
end

class AE_SpamLog < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :spam_logs
end

class AE_Subcategory < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :subcategories
end

class AE_Subscribe < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :subscribes
end

class AE_SubscribeStatus < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :subscribe_statuses
end

class AE_Subscriber < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :subscribers
end

class AE_UploadedFile < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :uploaded_files
end

class AE_User < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :users
end

class AE_Tag < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :tags
end

class AE_Tagging < ActiveRecord::Base
  establish_connection CONNECTION_PARAMS_AE
  self.table_name = :taggings
end