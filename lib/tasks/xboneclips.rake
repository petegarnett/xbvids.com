namespace :xboneclips do

  desc "Populate videos"
  task :populate_videos => [:environment] do
    xb = XboxService.new ENV['XBOX_API_KEY']
    User.all.each do |user|
      gamertag = user.gamertag

      if gamertag
        xuid = user.xuid

        if not xuid
          xuid = xb.xuid gamertag
          user.update_attributes(:xuid => xuid)
        end

        clips = xb.gameclips xuid

        clips.each do |clip|
          clip_id = clip['gameClipId']
          recorded_at = clip['dateRecorded']
          clip_type = clip['type']
          thumbnail_large = clip['thumbnails'][1]['uri']
          source_uri = clip['gameClipUris'][0]['uri']
          title = clip['titleName']

          unless Video.find_by_clip_id(clip_id)
            user.videos << Video.create({
              :clip_id => clip_id,
              :recorded_at => recorded_at,
              :clip_type => clip_type,
              :thumbnail_large => thumbnail_large,
              :source_uri => source_uri,
              :title => title
            })
          end
        end
      end
    end
  end

  desc "Upload videos"
  task :upload_videos => [:environment] do
    require 'open-uri'

    s3 = AWS::S3.new
    bucket_name = 'xbone-clips'

    Video.where(:is_uploaded => false).each do |video|
      video_file_name = '%s.mp4' % [video.clip_id]
      video_location = '/tmp/%s' % [video_file_name]

      puts "Downloading %s to %s" % [video.clip_id, video_location]
      open(video_location, 'wb') do |file|
        file << open(video.source_uri).read
      end

      puts "Uploading %s" % [video_location]

      s3.buckets[bucket_name].objects[video_file_name].write(:file => video_location, :acl => :public_read)

      video.update_attributes(:is_uploaded => true)
    end
  end
end
