xml.instruct!
xml.rss(:version => '2.0') do
  xml.channel do
    xml.title 'Xbox Clips Latest'
    xml.description 'Xbox Clips Latest'
    xml.link root_url

    @videos.each do |video|
      xml.item do
        xml.guid video.clip_id
        xml.title video.clip_id
        xml.description "New clip uploaded: %s by %s (%s)" % [video.title, video.user.gamertag, video_url(video.clip_id)]
        xml.pubDate video.created_at
      end
    end
  end
end
