class AddDepartmentToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_belongs_to :employees, :department
  end
end
