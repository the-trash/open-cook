# Соотношение полей баз данных AE и OC

=begin
	***********************************************************************

	1. user ae - user oc
	nick = login, username
	email = email
	created_at = created_at
	updated_at = updated_at
	crypted_password = crypted_password
	password_salt = salt
	roles = role_id

	2. authors ae - user oc
	name = username
	created_at = created_at
	updated_at = updated_at

	?
	1. user ae
	avatar_file_name
	avatar_content_type
	avatar_file_size
	banned_till
	ban_reason
	subscribe_state,     :default => "on"

	2. authors ae
	description
	avatar_file_name
	avatar_content_type
	avatar_file_size
	short_description

	***********************************************************************


	***********************************************************************

	uploaded_files ae - attached_files oc
	user_id = user_id
	storage_id = storage_id
	storage_type = storage_type
	file_file_name = attachment_file_name
	file_content_type = attachment_content_type
	file_file_size = attachment_file_size
	file_updated_at = attachment_updated_at
	parent_id = parent_id
	lft = lft
	rgt = rgt
	deptht = deptht
	created_at = created_at
	updated_at = updated_at

	?
	short_id
	title,             :default => "",          :null => false
	state,             :default => "published"

	***********************************************************************


	***********************************************************************

	comments ae - comments oc
	user_id = user_id
	commentable_id = commentable_id
	commentable_type = commentable_type
	parent_id = parent_id
	lft = lft
	rgt = rgt
	depth = depth
	created_at = created_at
	updated_at = updated_at
	ip = ip
	referer = referer
	user_agent = user_agent
	text = content, raw_content
	email, username = contacts ? возможно не так, смотря как формируется contacts

	?
	t.boolean  "deleted",          :default => false
	t.text     "prepared_text"
	t.string   "remote_ip"
	t.string   "remote_addr"
	t.string   "remote_host"


	t.integer  "holder_id"
	t.string   "commentable_url"
	t.string   "commentable_title"
	t.string   "commentable_state"
	t.string   "anchor"
	t.string   "title"
	t.string   "view_token"
	t.string   "state",             default: "draft"
	t.integer  "tolerance_time"
	t.boolean  "spam",              default: false

	***********************************************************************


	***********************************************************************

	1. categories ae - hubs oc
	title = title
	created_at = created_at
	updated_at = updated_at
	big_image_file_name, small_image_file_name = main_image_file_name (видимо разрешение разное, хотя в модельке не указано)
	big_image_content_type, small_image_content_type = main_image_content_type
	big_image_file_size, small_image_file_size = main_image_file_size
	slug = slug
	meta_keywords = keywords
	meta_description = description

	2. blogs ae = hubs oc
	user_id = user_id
	name = title
	body = content, raw_content
	created_at = created_at
	updated_at = updated_at
	image_file_name = main_image_file_name
	image_file_size = main_image_file_size
	image_content_type = main_image_content_type

	?
	categories ae:
	t.integer  "position"
	t.string   "meta_title"


	t.integer  "hub_id"
	t.string   "author"
	t.string   "copyright"
	t.text     "raw_intro"
	t.text     "intro"
	t.string   "hub_state",                default: "draft"
	t.string   "inline_tags"
	t.string   "legacy_url"
	t.datetime "published_at"
	t.string   "pubs_type",                default: "posts"
	t.boolean  "optgroup",                 default: false
	t.integer  "pubs_draft_count",         default: 0
	t.integer  "pubs_published_count",     default: 0
	t.integer  "pubs_deleted_count",       default: 0
	t.integer  "parent_id"
	t.integer  "lft"
	t.integer  "rgt"
	t.integer  "depth",                    default: 0
	t.datetime "main_image_updated_at"
	t.integer  "show_count",               default: 0
	t.string   "state",                    default: "draft"
	t.string   "moderation_state",         default: "raw"
	t.text     "moderator_note"
	t.string   "short_id"
	t.string   "friendly_id"
	t.integer  "storage_files_count",      default: 0
	t.integer  "storage_files_size",       default: 0
	t.integer  "draft_comments_count",     default: 0
	t.integer  "published_comments_count", default: 0
	t.integer  "deleted_comments_count",   default: 0

  ***********************************************************************
  

  ***********************************************************************

  1. tags ae - tags oc
  id = id
  name = name

  2. taggings ae - taggings oc
  id            = id
  tag_id        = tag_id
  taggable_id   = taggable_id
  taggable_type = taggable_type
  tagger_id     = tagger_id
  tagger_type   = tagger_type
  context       = context
  created_at    = created_at

  Taggble model only:  Author, Article

  metrics:
  "taggable_type" "count(*)"
  "Article" "5113"
  "Author"  "113"

  "context" "count(*)"
  "alphabet_letter" "113"
  "names" "967"
  "titles"  "1190"
  "words" "2956"

	***********************************************************************
=end
