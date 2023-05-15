class CreatePositionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :position_histories do |t|
      t.date :started_on
      t.date :finished_on
      t.references :employee, foreign_key: true
      t.references :position, foreign_key: true
      t.timestamps
    end
  end
end
