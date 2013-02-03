module PostsHelper
  def post_info post
    raw "<p>
      <b>owner:</b> #{post.user.login}
      <b>views:</b> #{post.show_count}
    </p>"
  end
end