namespace :assets do
  # rake assets:remove
  desc "Assets remove"
  task :remove do
    Rake::Task["assets:clobber"].invoke
  end

  # rake assets:rebuild
  desc "Assets rebuild"
  task :rebuild do
    env = 'RAILS_ENV=production'
    %w[ assets:clean assets:clobber assets:precompile].each do |task|
      cmd = "#{env} rake #{task}"
      puts   cmd
      system cmd
    end
  end
end
