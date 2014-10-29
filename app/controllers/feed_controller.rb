class FeedController < ApplicationController
  def twitter
    @videos = Video.order('created_at DESC').limit(50)
  end
end
