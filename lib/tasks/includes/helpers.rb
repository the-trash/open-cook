# helpers
def create_hub_category category
  user_root = User.root
  slug = make_slug category

  hub_category = Hub.new(
    title: category.title,
    slug: slug,
    keywords: category.meta_keywords,
    description: category.meta_description.to_s[0..250],
    state: :published,
    user: user_root,
    legacy_url: make_legacy_url_for_hub(category)
  )
  hub_category
end

def make_legacy_url_for_hub category
  legacy_url = if category.try(:category_id)
    parent_cat = AE_Category.find category.category_id
    "#{parent_cat.slug}/#{category.slug}"
  else
    "#{category.slug}"
  end
end

def find_ae_category category
  AE_Category.find category.id
end

def find_ae_subcategory category
  AE_Subcategory.find category.category_id
end

def find_parent_category category
  ae_category = (category.try(:category_id))? find_ae_subcategory(category) : find_ae_category(category)

  hub_category = Hub.find_by_slug ae_category.slug
  hub_category
end

def check_slug category
  hub = Hub.find_by_slug category.slug
  hub.present?
end

def make_slug category
  if check_slug category
    parent_hub_category = find_parent_category category
    if parent_hub_category.present?
      "#{parent_hub_category.slug}-#{category.slug}"
    else
      salt = (0..8).map { (65 + rand(26)).chr }.join
      "#{salt}-#{category.slug}"
    end
  else
    category.slug
  end
end

def find_user node
  begin
    return_user node
  rescue
    User.root
  end
end

def return_user node
  ae_user = AE_User.find node.user_id
  user = User.where('username = ?', ae_user.nick)
  user.first
end

def create_comment node, parent = nil
  print '*'

  user = find_user node
  obj = return_obj_for_comment node

  if obj
    root_comment = obj.comments.create!(
      user:        user,
      commentable: obj,
      raw_content: node.text,
      referer:     node.referer,
      user_agent:  node.user_agent,
      ip:          node.ip,
      parent_id:   parent.try(:id)
    )

    children = return_children_comment node
    children.each {|comment| create_comment comment, root_comment} if children.present?
  end
end

def return_blog id
  begin
    blog = AE_Blog.find id
    return Post.find_by_title blog.name
  rescue ActiveRecord::RecordNotFound
    return false
  end
end

def return_article id
  begin
    article = AE_Article.find id
    return Post.find_by_title article.title
  rescue ActiveRecord::RecordNotFound
    return false
  end
end

def return_obj_for_comment comment
  obj = case comment.commentable_type
    when 'Blog' then return_blog comment.commentable_id
    when 'Article' then return_article comment.commentable_id
  end
end

def return_children_comment comment
  AE_Comment.where('parent_id = ?', comment.id)
end

def return_obj_for_storage node
  obj = case node.storage_type
    when 'Blog' then return_blog node.storage_id
    when 'Article' then return_article node.storage_id
  end
end

def create_attached_files node, old_file
  user = find_user node
  obj  = return_obj_for_storage node

  if obj && File.exists?(old_file)
    obj.attached_files.create(
      user: user,
      attachment: File.open(old_file)
    )
  else
    puts old_file.to_s.red
  end
end

def create_main_image_file obj, old_file
  if File.exists?(old_file)
    obj.main_image(main_image: File.open(old_file))
    print '(f*)' if obj.save
  else
    puts old_file.to_s.yellow
  end
end

def puts_error obj, index, obj_count
  puts ''
  puts "#{obj.errors.to_a.to_s.red} => #{index+1}/#{obj_count}"
  puts ''
end

def create_blog node, hub
  user = find_user node

  blog = Post.new(
    title: node.name,
    raw_intro: node.body,
    raw_content: node.body,
    hub: hub,
    user: user,
    legacy_url: "blogs/#{node.id}"
  )
  blog
end

def create_post node
  user = find_user node
  article_category_slug = make_legacy_url_for_hub(AE_Subcategory.find(node.subcategory_id))
  hub = find_parent_category AE_Subcategory.find node.subcategory_id 

  post = Post.new(
    user: user,
    hub: hub,
    keywords: node.meta_keywords,
    description: node.meta_description.to_s[0..250],
    title: node.title,
    raw_intro: node.description,
    raw_content: node.body,
    state: node.state,
    legacy_url: "#{article_category_slug}/#{node.id}"
  )
  post
end
