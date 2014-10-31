namespace :xboneclips do

  desc "Populate videos"
  task :populate_videos => [:environment] do
    User.all.each do |user|
      FetchClipsWorker.perform_async user.id
    end
  end
end
