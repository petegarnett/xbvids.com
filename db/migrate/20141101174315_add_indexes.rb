class AddIndexes < ActiveRecord::Migration
  def change
    add_index :videos, :clip_id, :unique => true
    add_index :videos, :game_id
    add_index :videos, :user_id

    add_index :users, :gamertag
    add_index :users, :xuid

    add_index :games, :xgid
  end
end
