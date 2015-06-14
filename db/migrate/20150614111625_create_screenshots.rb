class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|

      t.integer :game_id
      t.integer :user_id

      t.string :xuid

      t.text :url
      t.integer :width
      t.integer :height

      t.text :thumbnail_small
      t.text :thumbnail_large

      t.datetime :date_taken
      t.string :screenshot_type
      t.boolean :saved_by_user

      t.integer :achievement_id
      t.integer :greatest_moment_id


      t.timestamps
    end
  end
end
