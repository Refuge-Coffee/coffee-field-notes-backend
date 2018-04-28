class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :website
      t.integer :rating, default: 0
      t.timestamps
    end
  end
end
