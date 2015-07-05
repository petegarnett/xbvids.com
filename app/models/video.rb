class Video < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  scope :uploaded, -> { where(:is_thumbnail_uploaded => true, :is_clip_uploaded => true) }

  def cdn_original_url
    return "https://d28pv9m582c384.cloudfront.net/%s.mp4" % [clip_id]
  end

  def cdn_rtmp_original_url
    return "rtmp://s16osvqw5sdzqt.cloudfront.net/cfx/st/mp4:%s.mp4".html_safe % [clip_id]
  end

  def cdn_clip_url
    return cdn_original_url if transcoded_notification_count == 0
    return "https://d16qbvaw6mbnw7.cloudfront.net/%s/720p.mp4" % [clip_id]
  end

  def cdn_small_clip_url
    return cdn_original_url if transcoded_notification_count == 0
    return "https://d16qbvaw6mbnw7.cloudfront.net/%s/240p.mp4" % [clip_id]
  end

  def cdn_medium_clip_url
    return cdn_original_url if transcoded_notification_count == 0
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

  def mlg_percent
      return 0 if mlglolwtf_count == 0

      (mlg_count.to_f / mlglolwtf_count) * 100
  end

  def lol_percent
      return 0 if mlglolwtf_count == 0

      (lol_count.to_f / mlglolwtf_count) * 100
  end

  def wtf_percent
      return 0 if mlglolwtf_count == 0

      (wtf_count.to_f / mlglolwtf_count) * 100
  end

  def mlglolwtf_count
      mlg_count.to_f + lol_count.to_f + wtf_count.to_f
  end
end
