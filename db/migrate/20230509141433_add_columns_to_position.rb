class AddColumnsToPosition < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.string :name
      t.integer :salary
      t.integer :vacation_days
    end
  end
end
