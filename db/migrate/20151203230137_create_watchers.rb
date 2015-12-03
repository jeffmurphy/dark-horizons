class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.string :apiurl
      t.string :apikey
      t.string :username
      t.string :password
      t.string :domain

      t.timestamps null: false
    end
  end
end
