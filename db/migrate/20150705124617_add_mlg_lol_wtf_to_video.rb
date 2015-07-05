class AddMlgLolWtfToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :mlg_count, :integer, :default => 0
    add_column :videos, :wtf_count, :integer, :default => 0
    add_column :videos, :lol_count, :integer, :default => 0
  end
end
