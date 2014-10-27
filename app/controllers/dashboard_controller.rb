class DashboardController < ApplicationController

   before_filter :authenticate_user!

  def index
    @videos = current_user.videos
  end
end
