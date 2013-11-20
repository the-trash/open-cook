require "#{Rails.root}/lib/tasks/includes/connect_ae_db"
require "#{Rails.root}/lib/tasks/includes/ae2oc_db"
require "#{Rails.root}/lib/tasks/includes/helpers"

# rake ae:user_start
namespace :ae do
  desc "Clean up DB"
  task clean_db: :environment do
    Role.destroy_all
    User.destroy_all

    Hub.delete_all
    Post.delete_all
    Comment.delete_all
  end

  desc "Create Role"
  task create_roles: [:environment, :clean_db] do
    admin_role = Role.create!(
      name: :admin,
      title: "Admin Role",
      description: "Admin can do anything"
    )

    blogger = Role.create!(
      name: :blogger,
      title: "Blogger role",
      description: "Blogger can manage his Comments and post in Blog hub"
    )

    author = Role.create!(
      name: :author,
      title: "Author role",
      description: "Blogger can manage his Comments and Post in Few Hubs (Articles, Blogs, Recipes, Videos)"
    )

    #######################################################
    # Update Role's Abilities
    #######################################################

    admin_role.create_rule(:system, :administrator)
    admin_role.rule_on(:system, :administrator)

    blogger.update_role(
      users: {
        cabinet: true
      },
      posts: {
        new:     true,
        create:  true,
        edit:    true,
        update:  true,
        rebuild: true,
        destroy: true
      },
      available_hubs: {
        blogs: true
      }
    )

    author.update_role(
      users: {
        cabinet: true
      },
      posts: {
        new:     true,
        create:  true,
        edit:    true,
        update:  true,
        rebuild: true,
        destroy: true
      },
      available_hubs: {
        blogs:    true,
        videos:   true,
        recipes:  true,
        articles: true,
        interviews: true
      }
    )

    puts "Roles created"
  end

  desc "Перетягиваем пользователей"
  task user_start: [:environment, :create_roles] do
    puts "User start =>"
    ae_users = AE_User.all
    # ae_users = AE_User.limit(2)
    user_count = ae_users.count

    # create admin
    puts "Create admin"
    admin = User.new(
      login: 'admin',
      username: 'admin',
      email: 'admin@example.com',
      password: 'admin',
      role_id: 1
    )

    if admin.save
      puts "Admin успешно создан"
    else
      puts "#{admin.errors.to_a.to_s.red}"
    end

    ae_users.each_with_index do |aeuser, index|
      user = User.new(
        login: aeuser.email,
        username: aeuser.nick,
        email: aeuser.email,
        role_id: 2,
        created_at: aeuser.created_at,
        updated_at: aeuser.updated_at,
        password: 'password'
      )

      if user.save
        puts "#{aeuser.nick} => #{index+1}/#{user_count}"
      else
        puts "#{aeuser.nick} - #{user.errors.to_a.to_s.red} => #{index+1}/#{user_count}"
      end
    end
  end

  desc "Создаем основной hub для категорий статей"
  task create_root_category_hub: [:environment, :user_start] do
    # Hub.delete_all
    puts "Создаем основной hub для категорий статей"
    create_system_hub(:system_article_categories, "КатегорииСтатей", :categories)
  end

  desc "Перетаскиваем категории в основной hub для категорий статей"
  task categories_start: [:environment, :create_root_category_hub] do
    ae_categories = AE_Category.all
    ae_categories_count = ae_categories.count

    # перетягиваем подкатегории
    ae_subcategories = AE_Subcategory.all
    ae_subcategories_count = ae_subcategories.count

    root_hub_categories = Hub.where(title: "КатегорииСтатей").first

    ae_categories.each_with_index do |ae_category, index|
      hub_category = create_hub_category ae_category

      if hub_category.save
        hub_category.move_to_child_of root_hub_categories
        puts "#{ae_category.slug} => #{index+1}/#{ae_categories_count}"
        
        puts "Перетягиваем подкатегории для #{ae_category.slug}"
        ae_subcategories.each_with_index do |ae_subcategory, index|
          hub_subcategory = create_hub_category ae_subcategory

          if ae_subcategory.category_id == ae_category.id
            if hub_subcategory.save
              hub_subcategory.move_to_child_of hub_category
              puts "#{hub_subcategory.slug} => #{index+1}/#{ae_subcategories_count}"
            else
              puts "#{hub_subcategory.slug} - #{hub_subcategory.errors.to_a.to_s.red} => #{index+1}/#{ae_subcategories_count}"
            end
          else
            next
          end
        end
      else
        puts "#{ae_category.slug} - #{hub_category.errors.to_a.to_s.red} => #{index+1}/#{ae_categories_count}"
      end
    end
  end

  desc "Перетаскиваем посты"
  task posts_start: [:environment, :categories_start] do
    Post.delete_all

    ae_articles = AE_Article.all
    ae_articles_count = ae_articles.count

    ae_articles.each_with_index do |ae_article, index|
      # user = find_user ae_article
      user = User.root
      hub = find_parent_category ae_article

      # решить вопрос с: image_file_name, pdf_file_name, swf_file_name, swf_see_file_name
      post = Post.new(
        user_id: user.id,
        hub_id: hub.id,
        keywords: ae_article.meta_keywords,
        description: ae_article.meta_description.to_s[0..250],
        title: ae_article.title,
        raw_intro: ae_article.description,
        raw_content: ae_article.body,
        state: ae_article.state
      )

      if post.save
        puts "#{post.title} => #{index+1}/#{ae_articles_count}"
      else
        puts "#{post.title} - #{post.errors.to_a.to_s.red} => #{index+1}/#{ae_articles_count}"
      end
    end
  end

  desc "Создаем Hub для блогов"
  task create_hub_blog: [:environment, :posts_start] do
    puts "Создаем основной hub для блогов"
    create_system_hub(:system_blogs, "Блоги", :posts)
  end

  desc "Перетягиваем блоги"
  # допилить не связанные 3 блога, связать с админом
  task blogs_start: [:environment, :create_hub_blog] do
    ae_blogs = AE_Blog.where.not('user_id IN (4,17,33)')
    ae_blogs_count = ae_blogs.count
    hub_blog = Hub.roots.where("title = ?", "Блоги").first

    puts "Перетягиваем блоги:"
    ae_blogs.each_with_index do |ae_blog, index|
      user_blog = find_user ae_blog

      blog = Post.new(
        title: ae_blog.name,
        raw_intro: ae_blog.body,
        raw_content: ae_blog.body,
        # main_image_file_name: ae_blog.image_file_name,
        # main_image_file_size: ae_blog.image_file_size,
        # main_image_content_type: ae_blog.image_content_type,
        hub_id: hub_blog.id,
        user_id: user_blog.id
      )

      if blog.save
        puts "#{blog.title} => #{index+1}/#{ae_blogs_count}"
      else
        puts "#{blog.title} - #{blog.errors.to_a.to_s.red} => #{index+1}/#{ae_blogs_count}"
      end
    end

    not_relation_blogs = AE_Blog.where('user_id IN (4,17,33)')
    not_relation_blogs.each_with_index do |bl, index|
      blog = Post.new(
        title: bl.name,
        raw_intro: bl.body,
        raw_content: bl.body,
        # main_image_file_name: bl.image_file_name,
        # main_image_file_size: bl.image_file_size,
        # main_image_content_type: bl.image_content_type,
        hub_id: hub_blog.id,
        user_id: User.root
      )

      if blog.save
        puts "#{blog.title} => #{index+1}/#{not_relation_blogs.count}"
      else
        puts "#{blog.title} - #{blog.errors.to_a.to_s.red} => #{index+1}/#{not_relation_blogs.count}"
      end
    end
  end

  desc "Перетягиваем комментарии"
  task comment_start: [:environment, :blogs_start] do
    puts 'Перетаскиваем комментарии:'
    ae_roots_comments = AE_Comment.where('depth = ?', 0)
    ae_roots_comments.each {|ae_root_comment| create_comment ae_root_comment}
  end

  desc "Перетягиваем загруженные файлы (uploaded_files)"
  task uploaded_files_start: [:environment] do
    ae_uploaded_files = AE_UploadedFile.all
    ae_uploaded_files_count = ae_uploaded_files.count

    
  end

  desc "Перетягиваем теги из AE в Open-cook"
  task tags_start: :environment do
    
  end
end
