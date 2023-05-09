class AddColumnsToPosition < ActiveRecord::Migration[7.0]
  def change
    change_table :positions do |t|
      t.string :name
      t.decimal :salary, precision: 5, scale: 2
    end
  end
end
