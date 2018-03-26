class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :content
      t.string :time_of_day
      t.belongs_to :bean
      t.timestamps
    end
  end
end
