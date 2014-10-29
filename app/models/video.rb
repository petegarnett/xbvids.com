class Video < ActiveRecord::Base
  belongs_to :user

  def cdn_clip_url
    return "https://d28pv9m582c384.cloudfront.net/%s.mp4" % [clip_id]
  end

  def cdn_thumbnail_url
    return "https://d3s9v1x1919qoo.cloudfront.net/%s.png" % [clip_id]
  end
end
