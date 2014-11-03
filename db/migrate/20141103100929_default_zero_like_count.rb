class DefaultZeroLikeCount < ActiveRecord::Migration
  def change
    change_column :videos, :like_count, :integer, :default => 0

    Video.where(:like_count => nil).update_all('like_count = 0')
  end
end
