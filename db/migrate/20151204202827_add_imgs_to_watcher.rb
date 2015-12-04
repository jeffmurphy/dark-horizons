class AddImgsToWatcher < ActiveRecord::Migration
  def change
    add_column :watchers, :okimg, :string
    add_column :watchers, :nokimg, :string
  end
end
