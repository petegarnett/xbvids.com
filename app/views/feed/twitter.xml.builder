xml.instruct!
xml.rss(:version => '2.0') do
  xml.channel do
    xml.title 'Xbox Clips Latest'
    xml.description 'Xbox Clips Latest'
    xml.link twitter_feed_url(:protocol => :https)

    @videos.each do |video|
      xml.item do
        xml.guid clip_url(video.clip_id, :protocol => :https)
        xml.title video.clip_id
        xml.description "New clip uploaded: %s by %s (%s)" % [video.title, video.user.gamertag, clip_url(video.clip_id, :protocol => :https)]
        xml.pubDate video.created_at.rfc2822
      end
    end
  end
end
