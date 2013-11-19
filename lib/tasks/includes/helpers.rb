# helpers
def create_system_hub slug, title, type
  User.root.hubs.where(title: title).first_or_create!(
    slug:  slug,
    title: title,
    pubs_type: type,
    state: :published
  )
end

def create_hub_category category
  user_root = User.root
  slug = make_slug category

  hub_category = Hub.nested_set.new(
    title: category.title,
    # main_image_file_name: category.big_image_file_name,
    # main_image_content_type: category.big_image_content_type,
    # main_image_file_size: category.big_image_file_size,
    slug: slug,
    keywords: category.meta_keywords,
    description: category.meta_description.to_s[0..250],
    state: :published,
    user: user_root
  )
  hub_category
end

def find_parent_category category
  ae_category = AE_Category.where('id = ?', category.category_id).first
  hub_category = Hub.where('slug = ?', ae_category.slug).first
  hub_category
end

def check_slug category
  hub = Hub.where('slug = ?', category.slug)
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