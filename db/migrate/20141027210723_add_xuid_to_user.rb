class AddXuidToUser < ActiveRecord::Migration
  def change
    add_column :users, :xuid, :string
  end
end
