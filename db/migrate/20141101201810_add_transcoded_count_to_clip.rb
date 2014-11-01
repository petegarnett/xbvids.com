class AddTranscodedCountToClip < ActiveRecord::Migration
  def up
    add_column :videos, :transcoded_notification_count, :integer, :default => 0
  end

  def down
    remove_column :videos, :transcoded_notification_count
  end
end
