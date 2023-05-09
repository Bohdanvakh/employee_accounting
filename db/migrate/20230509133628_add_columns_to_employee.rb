class AddColumnsToEmployee < ActiveRecord::Migration[7.0]
  def change
    change_table :employees do |t|
      t.integer :number
      t.string :surname
      t.string :first_name
      t.string :patronymic
      t.string :passport_data
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :home_address
      t.date :date_of_employment
    end
  end
end
