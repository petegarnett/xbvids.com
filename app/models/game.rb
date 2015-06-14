class Game < ActiveRecord::Base
  has_many :videos
  has_many :screenshots

  def self.top(count)
    select('games.*, COUNT(videos.id) AS videos_count').
      joins(:videos).
      group('games.id').
      order('videos_count DESC').
      limit(count)
  end
end
