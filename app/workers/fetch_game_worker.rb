class FetchGameWorker
  include Sidekiq::Worker

  def perform(game_id)

    xb = XboxService.new ENV['XBOX_API_KEY']

    game = Game.find(game_id)

    xb_game = xb.game game.title_id

    logger.info "Game %s: Raw game data = %s" % [game_id, xb_game]

    data = {
      :xgid => xb_game['ID'],
      :description => xb_game['Description'],
      :developer => xb_game['DeveloperName'],
      :rating => xb_game['AllTimeAverageRating'] * 100
    }

    xb_game['Images'].each do |image|
      if image['Purpose'] == 'BoxArt'
        data[:image_box] = image['Url']
      elsif image['Purpose'] == 'TitledHeroArt'
        data[:image_hero_title] = image['Url']
      elsif image['Purpose'] == 'SuperHeroArt'
        data[:image_hero_super] = image['Url']
      end
    end

    game.update_attributes(data)
  end
end
