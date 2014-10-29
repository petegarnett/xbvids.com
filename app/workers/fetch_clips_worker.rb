class FetchClipsWorker
  include Sidekiq::Worker

  def perform(user_id)

    xb = XboxService.new ENV['XBOX_API_KEY']

    user = User.find(user_id)

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
          video = Video.create({
            :clip_id => clip_id,
            :recorded_at => recorded_at,
            :clip_type => clip_type,
            :thumbnail_large => thumbnail_large,
            :source_uri => source_uri,
            :title => title
          })

          user.videos << video

          UploadClipWorker.perform_async(video.clip_id)
          UploadThumbnailWorker.perform_async(video.clip_id)
        end
      end
    end
  end
end
