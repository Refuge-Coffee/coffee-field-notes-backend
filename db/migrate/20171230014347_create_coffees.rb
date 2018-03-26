class CreateCoffees < ActiveRecord::Migration[5.1]
  def change
    create_table :beans do |t|
      t.string :name
      t.string :origin
      t.integer :elevation
      t.timestamps
    end
  end
end
