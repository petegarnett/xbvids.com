class UploadScreenshotWorker
  include Sidekiq::Worker

  def perform(screenshot_xuid)
    require 'open-uri'

    s3 = AWS::S3.new
    bucket_name = 'xbone-screenshots-eu'

    screenshot = Screenshot.find_by_xuid screenshot_xuid

    screenshot_file_name = '%s.png' % [screenshot.xuid]
    screenshot_location = '/tmp/%s' % [screenshot_file_name]

    logger.info "Downloading %s to %s" % [screenshot.xuid, screenshot_location]
    open(screenshot_location, 'wb') do |file|
      file << open(screenshot.url).read
    end

    logger.info "Uploading %s" % [screenshot_location]

    s3.buckets[bucket_name].objects[screenshot_file_name].write(:file => screenshot_location, :acl => :public_read)

    screenshot.update_attributes(:is_uploaded => true)
  end
end
