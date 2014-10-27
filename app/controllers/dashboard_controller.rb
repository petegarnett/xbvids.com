class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    if current_user.gamertag.nil?
      redirect_to settings_path
      return
    end

    @videos = current_user.videos
  end

  def settings

  end

  def settings_post
    gamertag = params[:gamertag]

    current_user.update_attributes(:gamertag => gamertag)

    redirect_to root_path
  end
end
