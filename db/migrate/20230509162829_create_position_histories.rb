class CreatePositionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :position_histories do |t|
      t.date :started_on
      t.date :finished_on
      t.integer :employee_id
      t.integer :position_id
      t.timestamps
    end
  end
end
