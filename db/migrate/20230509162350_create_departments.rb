class CreateDepartments < ActiveRecord::Migration[7.0]
  def up
    create_table :departments do |t|
      t.string :name
      t.string :abbreviation
      t.integer :manager_id

      t.timestamps
    end
  end
  def down
    drop_table :departments
  end
end
