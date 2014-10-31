class XboxService
  include HTTParty
  base_uri 'https://xboxapi.com'

  def initialize(api_key)
    @options = {
      :headers => {
        'X-Auth' => api_key
      }
    }
  end

  def xuid(gamertag)
    self.class.get('/v2/xuid/%s' % [URI.escape(gamertag)], @options).body
  end

  def gameclips(xuid)
    self.class.get('/v2/%d/game-clips' % [xuid], @options)
  end

  def game(title_id)
    self.class.get('/v2/game-details-hex/%x' % [title_id], @options)["Items"][0]
  end
end
