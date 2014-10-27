class AddGamerTagToUser < ActiveRecord::Migration
  def change
    add_column :users, :gamertag, :string
  end
end
