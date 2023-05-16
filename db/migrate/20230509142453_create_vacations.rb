class CreateVacations < ActiveRecord::Migration[7.0]
  def change
    create_table :vacations do |t|
      t.date :started_on
      t.date :finished_on
      t.belongs_to :employee

      t.timestamps
    end
  end
end
