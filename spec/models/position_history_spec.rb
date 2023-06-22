require 'rails_helper'

RSpec.describe PositionHistory, type: :model do
  let(:department) { FactoryBot.create(:department) }
  let(:employee) { FactoryBot.create(:employee, department: department, first_name: "Employee 1") }
  let(:employee2) { FactoryBot.create(:employee, department: department, first_name: "Employee 2") }
  let(:position) { FactoryBot.create(:position) }
  let(:manager_position) { FactoryBot.create(:position, name: Position::MANAGER) }
  # let(:position_history) { FactoryBot.create(:position_history, employee: employee, position: position) }

  describe "validations" do
    subject { FactoryBot.create(:position_history) }

    it { should validate_presence_of(:started_on).with_message("can't be blank") }
  end

  describe "methods" do
    it 'should show error that the last position is avtive' do
      FactoryBot.create(:position_history, employee: employee, started_on: 1.year.ago, finished_on: nil)
      position_history = FactoryBot.build(:position_history, employee: employee, started_on: 3.month.ago)

      expect(position_history).to be_invalid
      expect(position_history.errors[:base]).to include("The last position is active")
    end

    it 'should create new position when the last position is finished' do
      FactoryBot.create(:position_history, employee: employee, finished_on: Date.today)

      position_history = FactoryBot.build(:position_history, employee: employee)
      expect(position_history).to be_valid
    end

    context "validate_position_history_overlap method tests" do
      before do
        FactoryBot.create(:position_history, employee: employee, started_on: Date.new(2023, 10, 10), finished_on: Date.new(2023, 12, 10))
        FactoryBot.create(:position_history, employee: employee, started_on: Date.new(2024, 10, 11), finished_on: Date.new(2024, 12, 11))
      end

      it "should show error that Position cannot overlap with other positions" do
        position_history = FactoryBot.build(:position_history, employee: employee, started_on: Date.new(2023, 12, 9), finished_on: Date.new(2024, 10, 12))

        expect(position_history).to be_invalid
        expect(position_history.errors[:base]).to include("Position cannot overlap with other positions")
      end

      it "should show error that Position cannot overlap with other positions" do
        position_history = FactoryBot.build(:position_history, employee: employee, started_on: Date.new(2023, 12, 11), finished_on: Date.new(2024, 10, 10))

        expect(position_history).to be_valid
      end
    end
  end

  describe "associations" do
    subject { FactoryBot.create(:position_history) }

    it { should belong_to(:employee) }
    it { should belong_to(:position) }
  end
end

