class DashboardController < ApplicationController
  def index
    @videos = current_user.videos
  end
end
