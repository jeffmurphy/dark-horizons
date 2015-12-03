class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :domain
      t.datetime :posted_at
      t.string :notetype

      t.timestamps null: false
    end
  end
end
