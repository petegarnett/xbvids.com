class FetchScreenshotsWorker
  include Sidekiq::Worker

  def perform(user_id)

    xb = XboxService.new ENV['XBOX_API_KEY']

    user = User.find(user_id)

    gamertag = user.gamertag

    logger.info "User %s: Fetching screenshots for %s" % [user.id, user.gamertag]

    if gamertag
      xuid = user.xuid

      if not xuid
        xuid = xb.xuid gamertag
        user.update_attributes(:xuid => xuid)

        logger.info "User %s: Discovered xuid = %s" % [user.id, xuid]
      end

      screenshots = xb.screenshots xuid

      screenshots.each do |screenshot|

        logger.info "User %s: Screenshot raw data - %s" % [user.id, screenshot]

        width  = screenshot['resolutionWidth']
        height = screenshot['resolutionHeight']
        url    = screenshot['screenshotUris'][0]['uri']
        date_taken = screenshot['dateTaken']
        type = screenshot['type']
        game_title_id = screenshot['titleId']
        game_title_name = screenshot['titleName']
        saved_by_user = screenshot['savedByUser']
        achievement_id = screenshot['achievementId']
        greatest_moment_d = screenshot['greatestMomentId']
        thumbnail_small = ''
        thumbnail_large = ''
        screenshot_xuid = screenshot['screenshotId']

        screenshot['thumbnails'].each do |thumb|
          if thumb['thumbnailType'] == "Large"
            thumbnail_large = thumb['uri']
          else
            thumbnail_small = thumb['uri']
          end
        end

        unless Screenshot.find_by_xuid(screenshot_xuid)
          game = Game.find_by_title_id(game_title_id.to_s)

          if game.nil?
            game = Game.create({
              :title_id => game_title_id,
              :name     => game_title_name
            })

            logger.info "User %s: Found new game with title id = %s" % [user.id, game_title_id]

            FetchGameWorker.perform_async(game.id)
          else
            logger.info "User %s: Game already exists with title id = %s" % [user.id, game_title_id]
          end

          screenshot_record = Screenshot.create({
            :width => width,
            :height => height,
            :url => url,
            :date_taken => date_taken,
            :screenshot_type => type,
            :saved_by_user => saved_by_user,
            :achievement_id => achievement_id,
            :greatest_moment_id => greatest_moment_d,
            :thumbnail_small => thumbnail_small,
            :thumbnail_large => thumbnail_large,
            :xuid => screenshot_xuid
          })

          user.screenshots << screenshot_record
          game.screenshots << screenshot_record

          UploadScreenshotWorker.perform_async screenshot_xuid
        end
      end
    end
  end
end
