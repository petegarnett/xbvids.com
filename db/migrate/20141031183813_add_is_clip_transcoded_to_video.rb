class AddIsClipTranscodedToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :is_clip_transcoded, :boolean, :default => false
  end
end
