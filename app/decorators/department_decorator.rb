class DepartmentDecorator < Draper::Decorator
  delegate_all

  def current_manager
      object.employees.joins(position_histories: :position)
                      .where(positions: { name: Position::MANAGER })
                      .where(position_histories: { finished_on: nil })
                      .order('position_histories.started_on DESC')
                      .first
  end
end
