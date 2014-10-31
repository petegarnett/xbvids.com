class FeedController < ApplicationController
  def twitter
    @videos = Video.uploaded.order('created_at DESC').limit(50)
  end
end
