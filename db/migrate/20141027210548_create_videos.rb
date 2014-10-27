class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :clip_id
      t.datetime :recorded_at
      t.string :type
      t.string :thumbnail_large
      t.string :source_uri
      t.string :title

      t.timestamps
    end
  end
end
