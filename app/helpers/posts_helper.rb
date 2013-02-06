module PostsHelper
  def post_info post
    raw "<p>
      <b>owner:</b>
      <img src='http://lorempixel.com/30/30/people/?#{rand}' />
      <a href='/users/#{post.user.login}'>#{post.user.login}</a>
      <b>views:</b> #{post.show_count}
    </p>"
  end
end