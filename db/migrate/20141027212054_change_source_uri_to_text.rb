class ChangeSourceUriToText < ActiveRecord::Migration
  def change
    change_column :videos, :source_uri, :text
  end
end
