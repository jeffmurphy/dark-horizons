class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :domain
      t.string :okimg
      t.string :nokimg

      t.timestamps null: false
    end
  end
end
