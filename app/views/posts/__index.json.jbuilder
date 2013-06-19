json.array!(@posts) do |post|
  json.extract! post, :user_id, :author, :keywords, :description, :copyright, :title, :raw_content, :content, :main_image_url, :state, :first_published_at
  json.url post_url(post, format: :json)
end