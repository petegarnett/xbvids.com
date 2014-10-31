class AddIsThumbnailUploadedIsClipUploadedToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :is_thumbnail_uploaded, :boolean, :default => false
    add_column :videos, :is_clip_uploaded, :boolean, :default => false

    Video.where('is_uploaded = true').update_all('is_thumbnail_uploaded = true, is_clip_uploaded = true');
  end
end
