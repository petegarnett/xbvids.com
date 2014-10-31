class UploadThumbnailWorker
  include Sidekiq::Worker

  def perform(video_clip_id)
    require 'open-uri'

    s3 = AWS::S3.new
    bucket_name = 'xbone-thumbnails'

    video = Video.find_by_clip_id video_clip_id

    thumbnail_file_name = '%s.png' % [video.clip_id]
    thumbnail_location = '/tmp/%s' % [thumbnail_file_name]

    puts "Downloading %s to %s" % [video.clip_id, thumbnail_location]
    open(thumbnail_location, 'wb') do |file|
      file << open(video.thumbnail_large).read
    end

    puts "Uploading %s" % [thumbnail_location]

    s3.buckets[bucket_name].objects[thumbnail_file_name].write(:file => thumbnail_location, :acl => :public_read)

    video.update_attributes(:is_thumbnail_uploaded => true)
  end
end
