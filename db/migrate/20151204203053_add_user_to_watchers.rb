class AddUserToWatchers < ActiveRecord::Migration
  def change
    add_reference :watchers, :user, index: true, foreign_key: true
  end
end
