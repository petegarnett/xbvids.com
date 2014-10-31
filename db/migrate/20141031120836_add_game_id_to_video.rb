class AddGameIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :game_id, :integer
  end
end
