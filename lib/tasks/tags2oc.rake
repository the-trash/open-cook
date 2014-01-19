
namespace :ae do
  namespace :tags do
    desc "Перетягиваем сами теги из AE в Open-cook"
    task tags_start: :environment do
      puts "Tags cleaned" if ActsAsTaggableOn::Tag.delete_all
      puts 'Drag tags'.green
      ae_tags = AE_Tag.all
      ae_tags.each_with_index do |ae_tag, idx|
        tag = create_tag ae_tag 
        if tag.save
          print '*' if idx%50 == 0
        else
          puts_error tag, idx, ae_tags.count
        end
      end
      puts ''
    end

    desc "Перетягиваем полиморфную таблицу тегов из AE в Open-cook"
    task taggings_start: :environment do
      puts "Taggings cleaned" if ActsAsTaggableOn::Tagging.delete_all
      puts 'Drag polymorphic tag association'.green
      ae_taggings = AE_Tagging.all
      ae_taggings.each_with_index do |ae_tagging, idx|
        tagging = create_tagging ae_tagging 
        if tagging.save
          print '*' if idx%50 == 0
        else
          puts_error tagging, idx, ae_taggings.count
        end
      end
      puts ''
    end
  end
end
