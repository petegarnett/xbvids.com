class SnsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def consume
    # POST / HTTP/1.1
    # x-amz-sns-message-type: Notification
    # x-amz-sns-message-id: da41e39f-ea4d-435a-b922-c6aae3915ebe
    # x-amz-sns-topic-arn: arn:aws:sns:us-east-1:123456789012:MyTopic
    # x-amz-sns-subscription-arn: arn:aws:sns:us-east-1:123456789012:MyTopic:2bcfbf39-05c3-41de-beaa-fcfcc21c8f55
    # Content-Length: 761
    # Content-Type: text/plain; charset=UTF-8
    # Host: ec2-50-17-44-49.compute-1.amazonaws.com
    # Connection: Keep-Alive
    # User-Agent: Amazon Simple Notification Service Agent
    #
    # {
    #   "Type" : "Notification",
    #   "MessageId" : "da41e39f-ea4d-435a-b922-c6aae3915ebe",
    #   "TopicArn" : "arn:aws:sns:us-east-1:123456789012:MyTopic",
    #   "Subject" : "test",
    #   "Message" : "test message",
    #   "Timestamp" : "2012-04-25T21:49:25.719Z",
    #   "SignatureVersion" : "1",
    #   "Signature" : "EXAMPLElDMXvB8r9R83tGoNn0ecwd5UjllzsvSvbItzfaMpN2nk5HVSw7XnOn/49IkxDKz8YrlH2qJXj2iZB0Zo2O71c4qQk1fMUDi3LGpij7RCW7AW9vYYsSqIKRnFS94ilu7NFhUzLiieYr4BKHpdTmdD6c0esKEYBpabxDSc=",
    #   "SigningCertURL" : "https://sns.us-east-1.amazonaws.com/SimpleNotificationService-f3ecfb7224c7233fe7bb5f59f96de52f.pem",
    #   "UnsubscribeURL" : "https://sns.us-east-1.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:us-east-1:123456789012:MyTopic:2bcfbf39-05c3-41de-beaa-fcfcc21c8f55"
    # }

    message = AWS::SNS::Message.new JSON.parse(request.raw_post)

    if message.type == :SubscriptionConfirmation
      HTTParty.get message.subscribe_url
    elsif message.type == :Notification
      video_clip_id = JSON.parse(message.message)['input']['key'].gsub(/\.mp4$/, '')
      video = Video.find_by_clip_id video_clip_id

      if video
        Video.increment_counter(:transcoded_notification_count, video.id)
      end
    end

    head 200
  end
end
