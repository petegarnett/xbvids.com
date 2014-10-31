xml.instruct!
xml.urlset(
  :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9'
) do

  ['games', 'users'].each do |route|
    xml.url do
      xml.loc root_url() + route
      xml.last_mod DateTime.now
      xml.changefreq 'weekly'
      xml.priority 0.7
    end
  end

  Game.all.each do |game|
    if game.xgid
      xml.url do
        xml.loc game_url(game.xgid)
        xml.last_mod(game.updated_at)
        xml.changefreq 'weekly'
        xml.priority 0.8
      end
    end
  end

  User.all.each do |user|
    latest_video = user.videos.order('created_at').first

    if latest_video
      xml.url do
        xml.loc user_url(user.gamertag)
        xml.last_mod(latest_video.created_at)
        xml.changefreq 'weekly'
        xml.priority 0.9
      end
    end
  end

  Video.uploaded.each do |video|
    xml.url do
      xml.loc clip_url(video.clip_id)
      xml.last_mod(video.updated_at)
      xml.changefreq 'weekly'
      xml.priority 1.0
    end
  end
end
