require 'rails_helper'

RSpec.describe Vacation, type: :model do
  describe "validations" do
    subject { FactoryBot.create(:vacation) }

    it { should validate_presence_of(:started_on).with_message("can't be blank") }
    it { should validate_presence_of(:finished_on).with_message("can't be blank") }
    it { should validate_presence_of(:employee_id).with_message("can't be blank") }
  end

  describe "methods" do
    let(:employee) { FactoryBot.create(:employee) }

    subject { FactoryBot.build(:vacation, employee: employee) }

    describe "remaining_vacation_days" do
      context "when employee has remaining vacation days" do
        before do
          allow(employee).to receive(:vacation_days).and_return(10)
          allow(employee).to receive(:used_vacation_days).and_return(5)
        end
        it "does not add an error" do
          subject.validate

          expect(subject.errors[:base]).to_not include("Dont have enough days")
        end
      end

      context "when employee has no remaining vacation days" do
        before do
          allow(employee).to receive(:vacation_days).and_return(5)
          allow(employee).to receive(:used_vacation_days).and_return(5)
        end

        it "adds an error" do
          subject.validate

          expect(subject.errors[:base]).to include("Dont have enough days")
        end
      end
    end

    describe "not_past_date" do
      context "when vacationdate is in the future" do
        before do
          subject.started_on = DateTime.now + 1.day
          subject.finished_on = DateTime.now + 3.day
        end

        it "does not add an error" do
          subject.validate

          expect(subject.errors[:base]).to_not include("You cannot take vacation in a past date")
        end
      end

      context "when vacation date is in the past" do
        before do
          subject.started_on = DateTime.now - 3.days
          subject.finished_on = DateTime.now - 1.days
        end

        it "adds an error" do
          subject.validate

          expect(subject.errors[:base]).to include("You cannot take vacation in a past date")
        end
      end
    end

    describe "vacation_overlap" do
      let(:position) { FactoryBot.create(:position, vacation_days: 30) }
      let!(:employee) { FactoryBot.create(:employee) }
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, position: position, finished_on: nil) }
      let!(:exiting_vacation) { FactoryBot.create(:vacation, employee: employee, started_on: DateTime.now + 2.days, finished_on: DateTime.now + 3.days) }

      context "when vacation does not overlap with other vacations" do
        before do
          subject.started_on = DateTime.now + 4.days
          subject.finished_on = DateTime.now + 5.days
        end

        it "does not add an error" do
          subject.validate

          expect(subject.errors[:base]).to_not include("Vacation cannot overlap with other vacations")
        end
      end

      context "when vacation overlap with other vacations" do
        before do
          subject.started_on = exiting_vacation.started_on
          subject.finished_on = exiting_vacation.finished_on
        end

        it "adds an error" do
          subject.validate

          expect(subject.errors[:base]).to include("Vacation cannot overlap with other vacations")
        end
      end
    end

    describe "position_active" do
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, finished_on: nil) }

      context "when the last position is active" do
        before do
          allow(employee).to receive_message_chain(:position_histories, :last).and_return(position_history)
        end

        it "does not add an error" do
          subject.validate

          expect(subject.errors[:base]).to_not include("You can't add vacation because the last position is already finished.")
        end
      end
      context "when the last position in finished" do
        before do
          position_history.update(finished_on: DateTime.now - 1.day)
        end

        it "adds an error" do
          subject.validate

          expect(subject.errors[:base]).to include("You can't add vacation because the last position is already finished.")
        end
      end
    end

    describe "can_take_vacation" do
      let!(:department) { FactoryBot.create(:department) }
      let!(:position) { FactoryBot.create(:position, vacation_days: 30) }
      let!(:employee) { FactoryBot.create(:employee, department: department) }
      let!(:position_history) { FactoryBot.create(:position_history, employee: employee, position: position, finished_on: nil) }
      let!(:exiting_vacation) { FactoryBot.create(:vacation, employee: employee) }

      let!(:employees) { FactoryBot.create_list(:employee, 5, department: department) }

      let!(:position_histories) do
        employees.each do |emp|
          FactoryBot.create(:position_history, employee: emp, position: position, finished_on: nil)
        end
      end

      context "when there are less than 5 overlapping vacations" do
        before do
          subject.employee = employee
          subject.started_on = DateTime.now + 10.days
          subject.finished_on = DateTime.now + 12.days
        end

        it "does not add an error" do
          subject.validate

          expect(subject.errors[:base]).to_not include("You cannot take a vacation on this dates because 5 employees have already taken it.")
        end
      end

      context "when there are 5 or more overlapping vacations" do
        before do
          employees.each do |emp|
            FactoryBot.create(:vacation, employee: emp, started_on: DateTime.now + 5.days, finished_on: DateTime.now + 10.days)
          end

          subject.employee = employee
          subject.started_on = DateTime.now + 5.days
          subject.finished_on = DateTime.now + 10.days
        end

        it "adds error" do
          subject.validate

          expect(subject.errors[:base]).to include("You cannot take a vacation on this dates because 5 employees have already taken it.")
        end
      end
    end
  end

  describe "associations" do
    subject { FactoryBot.create(:vacation) }

    it { should belong_to(:employee) }
  end
end
