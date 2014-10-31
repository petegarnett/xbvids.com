class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :xgid
      t.string :name
      t.text :description
      t.string :developer
      t.string :image_box
      t.string :image_hero_title
      t.string :image_hero_super
      t.integer :rating
      t.string :title_id

      t.timestamps
    end
  end
end
