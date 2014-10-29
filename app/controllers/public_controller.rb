class PublicController < ApplicationController
  def user
    @user = User.find_by_gamertag(params[:user_id])

    if @user
      @videos = @user.videos
    end
  end

  def clip
    @video = Video.find_by_clip_id(params[:clip_id])
  end

  def home
    @videos = Video.all
  end

  def users
    @users = User.all
  end
end
