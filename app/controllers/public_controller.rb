class PublicController < ApplicationController
  before_filter :allow_iframe_requests, only: :clip_twitter_container

  def user
    @user = User.find_by_gamertag(params[:user_id])

    if @user
      @videos = @user.videos.uploaded.order('recorded_at DESC').paginate(:page => params[:page], :per_page => 24)
    end
  end

  def user_screenshots_list
    @user = User.find_by_gamertag(params[:user_id])

    if @user
      @screenshots = @user.screenshots.uploaded.order('date_taken DESC').paginate(:page => params[:page], :per_page => 24)
    end
  end

  def user_screenshots_view
    @user = User.find_by_gamertag(params[:user_id])
    @screenshot = @user.screenshots.uploaded.where(:xuid => params[:screenshot_id]).first
  end

  def clip
    @video = Video.find_by_clip_id(params[:clip_id])

    Video.increment_counter(:view_count, @video.id)

    @game_clips = @video.game.videos.uploaded.order("random()").limit(4)
    @user_clips = @video.user.videos.uploaded.order("random()").limit(4)
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

    @top_games = Game.top(10)
    @top_game = @top_games.first
    @top_game_videos = @top_game.videos.uploaded.order("view_count DESC").limit(4)

    @most_watched_videos = Video.uploaded.order("view_count DESC").limit(5)

    @latest_videos = Video.uploaded.order("recorded_at DESC").limit(5)
  end

  def users
    @users = User.all
  end

  def games
    @games = Game.top(9999999999)
  end

  def game
    @game = Game.find_by_xgid(params[:game_id])

    if @game
      @latest_videos = @game.videos.uploaded.order('recorded_at DESC').limit(10)
      @top_videos = @game.videos.uploaded.order('view_count DESC').limit(10)
    end
  end

  def popular
    @most_viewed = Video.uploaded.order('view_count DESC').limit(10)
    @most_likes  = Video.uploaded.order('like_count DESC').limit(10)
  end

  def vote
    video = Video.find_by_clip_id(params[:clip_id])

    vote_type = params[:type]
    field_map = {
        "mlg" => "mlg_count",
        "wtf" => "wtf_count",
        "lol" => "lol_count"
    }

    field = field_map[vote_type]

    if video and field
      Video.increment_counter(field, video.id)
      video.reload
    end

    response.headers['X-Cant-Be-Arsed'] = 'To-Stop-You-Voting-Multiple-Times'

    render :json => {
        :clip_id => video.clip_id,
        :wtf_percent => video.wtf_percent.to_i,
        :lol_percent => video.lol_percent.to_i,
        :mlg_percent => video.mlg_percent.to_i,
        :wtf_count   => video.wtf_count,
        :lol_count   => video.lol_count,
        :mlg_count   => video.mlg_count,
        :view_count  => video.view_count
    }
  end

  def faq
  end

  protected
    def allow_iframe_requests
      response.headers.delete('X-Frame-Options')
    end
end
