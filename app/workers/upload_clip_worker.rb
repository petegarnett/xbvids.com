class UploadClipsWorker
  include Sidekiq::Worker

  def perform(video_clip_id)
    require 'open-uri'

    s3 = AWS::S3.new
    bucket_name = 'xbone-clips'

    video = Video.find_by_clip_id video_clip_id

    unless video.is_uploaded
      video_file_name = '%s.mp4' % [video.clip_id]
      video_location = '/tmp/%s' % [video_file_name]

      puts "Downloading %s to %s" % [video.clip_id, video_location]
      open(video_location, 'wb') do |file|
        file << open(video.source_uri).read
      end

      puts "Uploading %s" % [video_location]

      s3.buckets[bucket_name].objects[video_file_name].write(:file => video_location, :acl => :public_read)

      video.update_attributes(:is_uploaded => true)
    end
  end
end
