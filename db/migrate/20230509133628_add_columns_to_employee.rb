class AddColumnsToEmployee < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :passport_data
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :home_address

      t.timestamps
    end
  end
end
