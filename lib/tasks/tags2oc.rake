
namespace :ae do
  desc "Перетягиваем теги из AE в Open-cook"
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

end
