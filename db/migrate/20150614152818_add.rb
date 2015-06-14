class Add < ActiveRecord::Migration
  def change
    add_column :screenshots, :is_uploaded, :boolean, :default => false
  end
end
