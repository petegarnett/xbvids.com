class ChangeTypeToClipTypeForVideo < ActiveRecord::Migration
  def change
    rename_column :videos, :type, :clip_type
  end
end
