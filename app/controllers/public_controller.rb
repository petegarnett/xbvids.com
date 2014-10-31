class PublicController < ApplicationController
  before_filter :allow_iframe_requests, only: :clip_twitter_container

  def user
    @user = User.find_by_gamertag(params[:user_id])

    if @user
      @videos = @user.videos.uploaded
    end
  end

  def clip
    @video = Video.find_by_clip_id(params[:clip_id])

    render :layout => 'player'
  end

  def clip_twitter_container
    @video = Video.find_by_clip_id(params[:clip_id])
    
    render :layout => nil
  end

  def home
    @videos = Video.uploaded
  end

  def users
    @users = User.all
  end

  protected
    def allow_iframe_requests
      response.headers.delete('X-Frame-Options')
    end
end
