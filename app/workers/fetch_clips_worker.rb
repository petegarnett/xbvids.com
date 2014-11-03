class FetchClipsWorker
  include Sidekiq::Worker

  def perform(user_id)

    xb = XboxService.new ENV['XBOX_API_KEY']

    user = User.find(user_id)

    gamertag = user.gamertag

    logger.info "User %s: Fetching clips for %s" % [user.id, user.gamertag]

    if gamertag
      xuid = user.xuid

      if not xuid
        xuid = xb.xuid gamertag
        user.update_attributes(:xuid => xuid)

        logger.info "User %s: Discovered xuid = %s" % [user.id, xuid]

        StatHat::API.ez_post_count("xbvids - worker - new gamertag", "xbvids@nicksays.co.uk", 1)
      end

      clips = xb.gameclips xuid

      clips.each do |clip|

        logger.info "User %s: Clip raw data - %s" % [user.id, clip]

        clip_id = clip['gameClipId']
        recorded_at = clip['dateRecorded']
        clip_type = clip['type']
        thumbnail_large = clip['thumbnails'][1]['uri']
        source_uri = clip['gameClipUris'][0]['uri']
        title = clip['titleName']
        user_caption = clip['userCaption']

        game_title_id = clip['titleId']

        unless Video.find_by_clip_id(clip_id)
          game = Game.find_by_title_id(game_title_id.to_s)

          if game.nil?
            game = Game.create({
              :title_id => game_title_id,
              :name     => title
            })

            logger.info "User %s: Found new game with title id = %s" % [user.id, game_title_id]

            FetchGameWorker.perform_async(game.id)
          end

          video = Video.create({
            :clip_id => clip_id,
            :recorded_at => recorded_at,
            :clip_type => clip_type,
            :thumbnail_large => thumbnail_large,
            :source_uri => source_uri,
            :title => title,
            :caption => user_caption
          })

          user.videos << video
          game.videos << video

          UploadClipWorker.perform_async(video.clip_id)
          UploadThumbnailWorker.perform_async(video.clip_id)

          StatHat::API.ez_post_count("xbvids - worker - new video", "xbvids@nicksays.co.uk", 1)
        end
      end
    end
  end
end
