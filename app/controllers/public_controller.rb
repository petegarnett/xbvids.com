class PublicController < ApplicationController
  before_filter :allow_iframe_requests, only: :clip_twitter_container

  def user
    @user = User.find_by_gamertag(params[:user_id])

    if @user
      @videos = @user.videos.uploaded.order('recorded_at DESC')
    end
  end

  def clip
    @video = Video.find_by_clip_id(params[:clip_id])

    Video.increment_counter(:view_count, @video.id)

    render :layout => 'player'
  end

  def clip_twitter_container
    @video = Video.find_by_clip_id(params[:clip_id])

    render :layout => nil
  end

  def home
    if user_signed_in?
      if current_user.gamertag.nil?
        redirect_to profile_path
        return
      end
    end

    @no_title = true
  end

  def users
    @users = User.all
  end

  def games
    @games = Game.all
  end

  def game
    @game = Game.find_by_xgid(params[:game_id])

    if @game
      @videos = @game.videos.uploaded.order('recorded_at DESC')
    end
  end

  def popular
    @most_viewed = Video.uploaded.order('view_count DESC').limit(10)
    @most_likes  = Video.uploaded.order('like_count DESC').limit(10)
  end

  def vote
    video = Video.find_by_clip_id(params[:clip_id])

    if video
      Video.increment_counter(:like_count, video.id)
    end

    response.headers['X-Cant-Be-Arsed'] = 'To-Stop-You-Voting-Multiple-Times'

    head 200
  end

  def faq
  end

  protected
    def allow_iframe_requests
      response.headers.delete('X-Frame-Options')
    end
end
