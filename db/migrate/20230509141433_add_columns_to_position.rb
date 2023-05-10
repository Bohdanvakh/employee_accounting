class AddColumnsToPosition < ActiveRecord::Migration[7.0]
  def change
    change_table :positions do |t|
      t.string :name
      t.decimal :salary, precision: 10, scale: 2
      t.integer :vacation_days
    end
  end
end
