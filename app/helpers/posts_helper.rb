module PostsHelper
  def comments_info post
    if post.respond_to? :comments
      show_link = link_to post.comments_sum, "#{post.show_path}#comments"
      return "<b>comments:</b> #{ show_link }"
    end
  end

  def post_info post
    raw "<p>
      <b>owner:</b>
      <img src='http://lorempixel.com/30/30/people/?#{rand}' />
      <a href='/users/#{post.user.login}'>#{post.user.login}</a>
      <b>views:</b> #{post.show_count}
      #{ comments_info(post) }
    </p>"
  end
end