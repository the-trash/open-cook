module PostsHelper
  def post_info post
    show_link = link_to post.total_comments_count, "#{post.show_path}#comments"

    raw "<p>
      <b>owner:</b>
      <img src='http://lorempixel.com/30/30/people/?#{rand}' />
      <a href='/users/#{post.user.login}'>#{post.user.login}</a>
      <b>views:</b> #{post.show_count}
      <b>comments:</b> #{ show_link }
    </p>"
  end
end