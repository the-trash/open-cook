require 'the_role'

class Role < ActiveRecord::Base
  include TheRole::RoleModel
end