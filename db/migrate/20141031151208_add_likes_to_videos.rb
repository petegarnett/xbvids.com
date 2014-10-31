class AddLikesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :like_count, :integer
  end
end
