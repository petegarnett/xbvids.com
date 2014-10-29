xml.instruct!
xml.rss do
  xml.channel do
    xml.title 'Xbox Clips Latest'

    @videos.each do |video|
      xml.item do
        xml.title video.clip_id
        xml.description "New clip uploaded: %s by %s (%s)" % [video.title, video.user.gamertag, video_url(video.clip_id)]
        xml.pubDate video.created_at
      end
    end
  end
end
