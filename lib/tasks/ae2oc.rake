require "#{Rails.root}/lib/tasks/includes/connect_ae_db"
require "#{Rails.root}/lib/tasks/includes/ae2oc_db"
require "#{Rails.root}/lib/tasks/includes/helpers"
require "#{Rails.root}/db/seeds/support/hubs_build"

namespace :ae do
  namespace :first do
    # rake ae:first:launch
    desc "Start all tasks"
    task launch: :environment do
      puts 'Data transfer is started'.green
      Rake::Task["ae:create:clean_db"].invoke
      Rake::Task["ae:create:create_roles"].invoke
      Rake::Task["ae:create:user_start"].invoke
      Rake::Task["ae:create:create_root_category_hub"].invoke
      Rake::Task["ae:create:categories_start"].invoke
      Rake::Task["ae:create:posts_start"].invoke
      Rake::Task["ae:create:create_hub_blog"].invoke
      Rake::Task["ae:create:blogs_start"].invoke
      Rake::Task["ae:create:comment_start"].invoke
      puts 'Data transfer is complete'.green
    end
  end

  namespace :create do
    # rake ae:create:clean_db
    desc "Clean up DB"
    task clean_db: :environment do
      puts "Role cleaned" if Role.destroy_all
      puts "Users cleaned" if User.destroy_all

      puts "Hubs cleaned" if Hub.delete_all
      puts "Posts cleaned" if Post.delete_all
      puts "Comments cleaned" if Comment.delete_all
      # puts "Downloaded files cleaned" if AttachedFile.delete_all
    end

    # rake ae:create:create_roles
    desc "Create Role"
    task create_roles: :environment do
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

    # rake ae:create:user_start
    desc "Drag users"
    task user_start: :environment do
      puts "Drag users:".yellow
      ae_users = AE_User.all
      # ae_users = AE_User.limit(2)
      user_count = ae_users.count

      # create admin
      admin = User.new(
        login: 'admin',
        username: 'admin',
        email: 'admin@example.com',
        password: 'admin',
        role_id: 1
      )

      if admin.save
        puts "Admin created"
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
          print '*'
          # puts "#{aeuser.nick} => #{index+1}/#{user_count}"
        else
          puts_error aeuser, index, user_count
        end
      end

      puts ''
    end

    # rake ae:create:system_hubs
    desc "create system_hubs"
    task system_hubs: :environment do
      HubsBuild.create_system_hub(:system_pages, 'System pages', :pages)

      system_hub = HubsBuild.create_system_hub(:system_hubs, 'System hubs', :pages)

      HubsBuild.create_system_hub(:interviews, 'Interviews',   :posts, system_hub)
      HubsBuild.create_system_hub(:articles,   'Articles',     :posts, system_hub)
      HubsBuild.create_system_hub(:recipes,    'Recipes',      :posts, system_hub)
      HubsBuild.create_system_hub(:videos,     'Videos',       :posts, system_hub)
      HubsBuild.create_system_hub(:blogs,      'Blogs',        :posts, system_hub)

      puts "Basic Hubs created".yellow
    end

    # rake ae:create:create_root_category_hub
    desc "Create the main hub for articles"
    task create_root_category_hub: :environment do
      puts "Create the main hub for articles".yellow
      create_system_hub(:system_article_categories, "КатегорииСтатей", :categories)
    end
    
    # rake ae:create:categories_start
    desc "Drag the categories in the main hub for articles"
    task categories_start: :environment do
      ae_categories = AE_Category.all
      ae_categories_count = ae_categories.count

      puts "Drag the categories in the main hub for articles:".yellow
      # Drag subcategories
      ae_subcategories = AE_Subcategory.all
      ae_subcategories_count = ae_subcategories.count

      root_hub_categories = Hub.where(title: "КатегорииСтатей").first

      ae_categories.each_with_index do |ae_category, index|
        hub_category = create_hub_category ae_category

        if hub_category.save
          hub_category.move_to_child_of root_hub_categories

          print "*"
          # puts "#{ae_category.slug} => #{index+1}/#{ae_categories_count}"

          ae_subcategories.each_with_index do |ae_subcategory, index|
            hub_subcategory = create_hub_category ae_subcategory

            if ae_subcategory.category_id == ae_category.id
              if hub_subcategory.save
                hub_subcategory.move_to_child_of hub_category
                print '.'
                # puts "#{hub_subcategory.slug} => #{index+1}/#{ae_subcategories_count}"
              else
                puts_error hub_subcategory, index, ae_subcategories_count
              end
            else
              next
            end
          end
        else
          puts_error ae_category, index, ae_categories_count
        end
      end

      puts ''
    end

    # rake ae:create:posts_start
    desc "Drag posts"
    task posts_start: :environment do
      puts 'Drag posts:'.yellow

      ae_articles = AE_Article.all
      ae_articles_count = ae_articles.count

      ae_articles.each_with_index do |ae_article, index|
        # user = find_user ae_article
        user = User.root
        hub = find_parent_category ae_article
        old_file = "#{Rails.root}/public/system/old_uploads/articles"+
                   "/original/#{ae_article.id}#{File.extname(ae_article.image_file_name)}"
        article_category_slug = make_legacy_url_for_hub(AE_Subcategory.find(ae_article.subcategory_id))

        # add legacy_url !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        post = Post.new(
          user_id: user.id,
          hub_id: hub.id,
          keywords: ae_article.meta_keywords,
          description: ae_article.meta_description.to_s[0..250],
          title: ae_article.title,
          raw_intro: ae_article.description,
          raw_content: ae_article.body,
          state: ae_article.state,
          legacy_url: "#{article_category_slug}/#{ae_article.id}"
        )

        if post.save
          print '*'
          # create_main_image_file post, old_file
          # print "(#{index+1}/#{ae_articles_count})"
        else
          puts_error post, index, ae_articles_count
        end
      end

      puts ''
    end

    # rake ae:create:create_hub_blog
    desc "Create Hub for blogs"
    task create_hub_blog: :environment do
      puts "Create Hub for blogs".yellow
      create_system_hub(:system_blogs, "Блоги", :posts)
    end

    # rake ae:create:blogs_start
    desc "Drag Blogs"
    task blogs_start: :environment do
      ae_blogs = AE_Blog.where.not('user_id IN (4,17,33)')
      ae_blogs_count = ae_blogs.count
      hub_blog = Hub.roots.where("title = ?", "Блоги").first

      puts "Drag Blogs:".yellow
      ae_blogs.each_with_index do |ae_blog, index|
        user_blog = find_user ae_blog
        old_file = "#{Rails.root}/public/system/old_uploads/blogs"+
                   "/original/#{ae_blog.id}#{File.extname(ae_blog.image_file_name)}"

        blog = Post.new(
          title: ae_blog.name,
          raw_intro: ae_blog.body,
          raw_content: ae_blog.body,
          hub_id: hub_blog.id,
          user_id: user_blog.id
        )

        if blog.save
          print "*"
          # create_main_image_file blog, old_file
        else
          puts_error blog, index, ae_blogs_count
        end
      end

      not_relation_blogs = AE_Blog.where('user_id IN (4,17,33)')
      not_relation_blogs.each_with_index do |bl, index|
        old_file = "#{Rails.root}/public/system/old_uploads/blogs"+
                   "/original/#{bl.id}#{File.extname(bl.image_file_name)}"

        blog = Post.new(
          title: bl.name,
          raw_intro: bl.body,
          raw_content: bl.body,
          hub_id: hub_blog.id,
          user_id: User.root
        )

        if blog.save
          print "*"
          # create_main_image_file blog, old_file
        else
          puts_error blog, index, not_relation_blogs.count
        end
      end

      puts ''
    end

    # rake ae:create:comment_start
    desc "Drag comments"
    task comment_start: :environment do
      puts 'Drag comments:'.yellow
      ae_roots_comments = AE_Comment.where('depth = ?', 0)
      ae_roots_comments.each {|ae_root_comment| create_comment ae_root_comment}
      puts ''
    end
  end


  # ***********************************************************************
  desc "Перетягиваем загруженные файлы (uploaded_files)"
  task uploaded_files_start: [:environment, :comment_start] do
    puts ''
    puts 'Перетаскиваем загруженные файлы (uploaded_files)'
    ae_uploaded_files = AE_UploadedFile.all
    # ae_uploaded_files = AE_UploadedFile.limit(5)

    ae_uploaded_files.each do |ae_uploaded_file|
      # Положил в папку с проектом, указывать путь под себя
      old_file = "#{Rails.root}/public/system/old_uploads/uploads/" +
                  "#{ae_uploaded_file.storage_type.downcase}/#{ae_uploaded_file.storage_id}/"+
                  "files/original/#{ae_uploaded_file.file_file_name}"

      create_attached_files ae_uploaded_file, old_file
    end
  end

  desc "Перетягиваем теги из AE в Open-cook"
  task tags_start: :environment do
    
  end
end
