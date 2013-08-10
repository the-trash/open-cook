# encoding: UTF-8
module CommentsBuild
  class << self
    def create user, obj, parent = nil
      print '.'

      obj.comments.create!(
        user:        user,
        commentable: obj,
        title:       Faker::Lorem.sentence,
        contacts:    Faker::Lorem.sentence,
        raw_content: Faker::Lorem.paragraphs(4).join,
        parent_id:   parent.try(:id)
      )
    end

    def tree users, obj, depth = 3, parent = nil, num = 3
      return false if depth == 0

      num.times do
        user   = users.sample
        parent = self.create(user, obj, parent)
        self.tree(users, obj, depth.pred, parent)
      end
    end
  end
end

after 'development:pages' do
  users = User.all
  pages = Page.all
  posts = Post.all

  pages.each_with_index do |page, index|
    CommentsBuild.tree(users, page, 2, nil, 2)
    puts
    puts "Comments for page created #{index.next}/#{pages.count}"
  end

  posts.each_with_index do |post, index|
    CommentsBuild.tree(users, post, 2, nil, 2)
    puts
    puts "Comments for post created #{index.next}/#{posts.count}"
  end

  puts "Comments created"
end