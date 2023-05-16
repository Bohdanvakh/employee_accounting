class CreatePositionHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :position_histories do |t|
      t.date :started_on
      t.date :finished_on
      t.belongs_to :employee
      t.belongs_to :position
      t.timestamps
    end
  end
end
