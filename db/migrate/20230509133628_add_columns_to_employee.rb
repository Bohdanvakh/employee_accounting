class AddColumnsToEmployee < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :passport_data
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :home_address
      t.date :employed_on
      t.decimal :salary, precision: 10, scale: 2
    end
  end
end
