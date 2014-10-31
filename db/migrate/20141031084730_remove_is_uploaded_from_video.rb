class RemoveIsUploadedFromVideo < ActiveRecord::Migration
  def change
    remove_column :videos, :is_uploaded
  end
end
