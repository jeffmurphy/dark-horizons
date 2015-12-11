class AddPostDataToWatchers < ActiveRecord::Migration
  def change
    add_column :watchers, :post, :text
  end
end
