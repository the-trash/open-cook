module PostsHelper
  def tags_links tags
    str = tags.split(', ').map do |tag|
      link_to tag, tag_url(tag)
    end.join(', ')

    raw str
  end
end