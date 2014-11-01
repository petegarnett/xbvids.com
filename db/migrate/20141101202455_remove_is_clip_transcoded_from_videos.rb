class RemoveIsClipTranscodedFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :is_clip_transcoded
  end
end
