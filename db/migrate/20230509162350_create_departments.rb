class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :abbreviation
      t.integer :manager_id
      t.integer :max_employees
      t.integer :employees_on_vacation

      t.timestamps
    end
  end
end
