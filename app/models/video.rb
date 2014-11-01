class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  scope :uploaded, -> { where(:is_thumbnail_uploaded => true, :is_clip_uploaded => true) }

  def cdn_original_url
    return "https://d28pv9m582c384.cloudfront.net/%s.mp4" % [clip_id]
  end

  def cdn_clip_url
    return "https://d16qbvaw6mbnw7.cloudfront.net/%s/720p.mp4" % [clip_id]
  end

  def cdn_small_clip_url
    return "https://d16qbvaw6mbnw7.cloudfront.net/%s/240p.mp4" % [clip_id]
  end

  def cdn_medium_clip_url
    return "https://d16qbvaw6mbnw7.cloudfront.net/%s/480p.mp4" % [clip_id]
  end

  def cdn_thumbnail_url
    return "https://d3s9v1x1919qoo.cloudfront.net/%s.png" % [clip_id]
  end

  def like_count
    self[:like_count] || 0
  end

  def is_uploaded?
    is_thumbnail_uploaded and is_clip_uploaded
  end
end
