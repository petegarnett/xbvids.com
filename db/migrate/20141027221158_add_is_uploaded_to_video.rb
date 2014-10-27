class AddIsUploadedToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :is_uploaded, :bool, :default => false
  end
end
