module Api
  module V1
    class VideosController < ActionController::Base
      def firehose
        cursor = params[:cursor].to_i
        count = params[:count].to_i

        if cursor < 0
          cursor = 0
        end

        if count <= 0
          count = 50
        elsif count > 500
          count = 500
        end

        @videos = Video
          .includes(:user)
          .paginate(:page => 1, :per_page => count)
          .where('id > ?', cursor)
      end
    end
  end
end
