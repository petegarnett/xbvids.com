namespace :xboneclips do

  desc "Populate content"
  task :populate_content => [:populate_videos, :populate_screenshots]

  desc "Populate videos"
  task :populate_videos => [:environment] do
    User.all.each do |user|
      FetchClipsWorker.perform_async user.id
    end
  end

  desc "Populate screenshots"
  task :populate_screenshots => [:environment] do
    User.all.each do |user|
      FetchScreenshotsWorker.perform_async user.id
    end
  end
end
