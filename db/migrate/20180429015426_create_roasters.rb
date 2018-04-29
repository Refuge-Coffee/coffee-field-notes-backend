class CreateRoasters < ActiveRecord::Migration[5.1]
  def change
    create_table :roasters do |t|
      t.string :name
      t.timestamps
    end

    change_table :locations do |t|
      t.belongs_to :roaster
    end

    change_table :beans do |t|
      t.belongs_to :roaster
    end
  end
end
